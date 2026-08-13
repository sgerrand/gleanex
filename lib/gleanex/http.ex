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
    * `:req_options` - extra `Req` options, merged over the config's. `:headers`
      and `:params` are merged entry by entry rather than wholesale, so adding
      one of either keeps the ones already there; see `build_request/3`.
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
      send_request(config, api, operation, call)
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

  defp to_api(segment) do
    Enum.find(Config.apis(), :client, &(Atom.to_string(&1) == segment))
  end

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

  `:headers` and `:params` are collections of named values, so an override
  replaces the entries it names and leaves the rest in place. Everything else is
  a single value and an override replaces it outright.
  """
  @spec build_request(Config.t(), Config.api(), map) :: Req.Request.t()
  def build_request(config, api, operation) do
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
    |> merge_options(retry_options(config, api, opts))
    |> merge_options(config.req_options)
    |> merge_options(Keyword.get(opts, :req_options, []))
    |> Req.new()
  end

  # `Keyword.merge/2` replaces a whole value, which is right for the options
  # holding one setting and wrong for the two holding a collection of named
  # ones. A config adding a header would take the user agent with it, and one
  # setting `:params` would take an operation's own query parameters with it,
  # leaving a request Glean accepts and answers wrongly. Those two are merged by
  # name instead: an override displaces the entry it names and nothing else.
  defp merge_options(base, overrides) do
    Keyword.merge(base, overrides, fn
      :headers, existing, new -> merge_named(existing, new, &header_name/1)
      :params, existing, new -> merge_named(existing, new, &to_string/1)
      _key, _existing, new -> new
    end)
  end

  defp merge_named(existing, new, name) do
    new = pairs(new)
    replaced = MapSet.new(new, fn {key, _value} -> name.(key) end)

    Enum.reject(pairs(existing), fn {key, _value} ->
      MapSet.member?(replaced, name.(key))
    end) ++ new
  end

  # `Req` takes either option as a map or as a list of pairs; comparing them
  # needs one shape.
  defp pairs(values) when is_map(values), do: Map.to_list(values)
  defp pairs(values) when is_list(values), do: values

  # Header names are case insensitive, so an override spelled "User-Agent" has
  # to displace the "user-agent" set above. Query parameter names are not, and
  # are only run through `to_string/1` so that the atom keys generated
  # operations use and the strings a caller may write compare equal.
  defp header_name(name), do: name |> to_string() |> String.downcase()

  defp send_request(config, api, operation, call) do
    metadata = %{
      api: api,
      operation: call,
      method: Map.get(operation, :method, :get),
      url: Map.get(operation, :url, "/")
    }

    :telemetry.span([:gleanex, :request], metadata, fn ->
      response = config |> build_request(api, operation) |> Req.request()
      result = handle(response, operation, call)

      {result, Map.merge(metadata, result_metadata(response))}
    end)
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

  # The API is passed on because a policy left at `:default` means different
  # things against different ones: Indexing is writes, where most of what looks
  # transient may already have been applied. See `Gleanex.Retry`.
  defp retry_options(config, api, opts) do
    opts
    |> Keyword.get(:retry, config.retry)
    |> Gleanex.Retry.to_req_options(api)
  end

  defp handle({:ok, %Req.Response{status: status} = response}, operation, _call)
       when status in 200..299 do
    {:ok, decode(response, operation)}
  end

  defp handle({:ok, %Req.Response{} = response}, _operation, call) do
    {:error, Error.from_response(response, call)}
  end

  defp handle({:error, exception}, _operation, call) do
    {:error, Error.from_exception(exception, call)}
  end

  defp decode(%Req.Response{body: body, status: status}, operation) do
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
