defmodule Gleanex.HTTP do
  @moduledoc """
  The transport behind every generated operation.

  Generated operation functions end in a call to `request/1` with a description
  of the call. This module turns that description into a `Req` request, sends
  it, and normalises the result to `{:ok, term}` or `{:error, Gleanex.Error.t()}`.

  ## Per call options

  Every generated operation takes a trailing `opts` keyword list. Alongside the
  operation's own query parameters it understands:

    * `:config` - the `Gleanex.Config` to use. Falls back to
      `Gleanex.Config.default/0`, which reads the application and system
      environment.
    * `:receive_timeout` - override the config's timeout for this call.
    * `:retry` - override the config's `Gleanex.Retry` policy for this call.
    * `:req_options` - extra `Req` options, merged over the config's.
    * `:client` - swap this module out entirely, handled by the generated code.

  ## Telemetry

  Each request emits a span under `[:gleanex, :request]`:

    * `[:gleanex, :request, :start]` with `%{system_time: integer}`
    * `[:gleanex, :request, :stop]` with `%{duration: integer}`
    * `[:gleanex, :request, :exception]` with `%{duration: integer}`

  Metadata carries `:api`, `:operation`, `:method` and `:url`, and the stop event
  adds `:status` or `:error`.
  """

  alias Gleanex.Body
  alias Gleanex.Config
  alias Gleanex.Decoder
  alias Gleanex.Error

  @doc """
  Run a generated operation description.
  """
  @spec request(map) :: {:ok, term} | {:error, Error.t()}
  def request(operation) when is_map(operation) do
    opts = Map.get(operation, :opts, [])
    call = Map.get(operation, :call)
    api = api_for(call)

    with {:ok, config} <- fetch_config(opts),
         :ok <- Config.check_scope(config, api) do
      send_request(config, api, operation)
    end
  end

  @doc """
  Which of the four APIs an operation module belongs to.

  Derived from the module name, so `Gleanex.Indexing.Documents` resolves to
  `:indexing`. Unrecognised modules fall back to `:client`.
  """
  @spec api_for({module, atom} | module | nil) :: Config.api()
  def api_for({module, _function}), do: api_for(module)

  def api_for(module) when is_atom(module) and not is_nil(module) do
    case Module.split(module) do
      ["Gleanex", segment | _] -> segment |> Macro.underscore() |> to_api()
      _ -> :client
    end
  rescue
    ArgumentError -> :client
  end

  def api_for(_), do: :client

  defp to_api("indexing"), do: :indexing
  defp to_api("platform"), do: :platform
  defp to_api("admin"), do: :admin
  defp to_api(_), do: :client

  defp fetch_config(opts) do
    case Keyword.get(opts, :config) do
      %Config{} = config ->
        {:ok, config}

      nil ->
        {:ok, Config.default()}

      other ->
        {:error, Error.config("expected :config to be a Gleanex.Config, got: #{inspect(other)}")}
    end
  rescue
    error in Error -> {:error, error}
  end

  @doc """
  Build the `Req` request for an operation without sending it.

  Exposed for `Gleanex.Streaming`, which needs the same URL, auth and retry
  handling but has to consume the response body as it arrives rather than all at
  once. Options under the operation's `:opts` are applied last, so a caller can
  add `into: :self` through `req_options`.
  """
  @spec build_request(Config.t(), Config.api(), map) :: Req.Request.t()
  def build_request(config, api, operation), do: build(config, api, operation)

  defp send_request(config, api, operation) do
    call = Map.get(operation, :call)

    metadata = %{
      api: api,
      operation: call,
      method: Map.get(operation, :method, :get),
      url: Map.get(operation, :url, "/")
    }

    :telemetry.span([:gleanex, :request], metadata, fn ->
      response = config |> build(api, operation) |> Req.request()
      result = handle(response, operation, call)

      {result, Map.merge(metadata, result_metadata(response))}
    end)
  end

  defp build(config, api, operation) do
    opts = Map.get(operation, :opts, [])

    [
      method: Map.get(operation, :method, :get),
      base_url: Config.base_url(config, api),
      url: Map.get(operation, :url, "/"),
      auth: {:bearer, config.token},
      receive_timeout: Keyword.get(opts, :receive_timeout, config.receive_timeout),
      headers: [{"user-agent", user_agent()}],
      decode_body: true
    ]
    |> add_query(Map.get(operation, :query))
    |> add_body(operation)
    |> Keyword.merge(retry_options(config, opts))
    |> Keyword.merge(config.req_options)
    |> Keyword.merge(Keyword.get(opts, :req_options, []))
    |> Req.new()
  end

  defp add_query(req_opts, nil), do: req_opts
  defp add_query(req_opts, []), do: req_opts
  defp add_query(req_opts, query), do: Keyword.put(req_opts, :params, query)

  defp add_body(req_opts, operation) do
    case Map.fetch(operation, :body) do
      :error -> req_opts
      {:ok, nil} -> req_opts
      {:ok, body} -> Keyword.put(req_opts, body_option(operation), Body.encode(body))
    end
  end

  # `:request` lists the content types the operation accepts, as
  # `[{content_type, type}]`. Anything that is not JSON is sent as multipart,
  # which covers Glean's file upload endpoints.
  defp body_option(operation) do
    case Map.get(operation, :request) do
      [{content_type, _type} | _] when is_binary(content_type) ->
        if String.contains?(content_type, "json"), do: :json, else: :form_multipart

      _ ->
        :json
    end
  end

  defp retry_options(config, opts) do
    opts
    |> Keyword.get(:retry, config.retry)
    |> Gleanex.Retry.to_req_options()
  end

  defp handle({:ok, %Req.Response{status: status} = response}, operation, _call)
       when status in 200..299 do
    {:ok, decode(response, operation, status)}
  end

  defp handle({:ok, %Req.Response{} = response}, _operation, call) do
    {:error, Error.from_response(response, call)}
  end

  defp handle({:error, exception}, _operation, call) do
    {:error, Error.from_exception(exception, call)}
  end

  defp decode(%Req.Response{body: body}, operation, status) do
    body = normalise_body(body)

    case response_type(operation, status) do
      nil -> body
      type -> Decoder.decode(body, type)
    end
  end

  defp normalise_body(""), do: nil
  defp normalise_body(body), do: body

  defp response_type(operation, status) do
    responses = Map.get(operation, :response, [])

    Enum.find_value(responses, fn
      {^status, type} -> type
      {:default, type} -> type
      _ -> nil
    end)
  end

  defp result_metadata({:ok, %Req.Response{status: status}}), do: %{status: status}
  defp result_metadata({:error, exception}), do: %{error: exception}

  defp user_agent do
    version = Application.spec(:gleanex, :vsn) || ~c"dev"
    "gleanex/#{version}"
  end
end
