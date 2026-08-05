defmodule Gleanex.Streaming do
  @moduledoc """
  Consume Glean's streaming endpoints as they arrive.

  Generated operations buffer the whole response before returning, which is the
  right thing for ordinary calls and the wrong thing for a chat or agent run
  that is meant to appear a token at a time. These functions send the same
  requests but hand back a `Stream`.

  Glean uses two wire formats and this module covers both:

    * agent runs are `text/event-stream`, decoded by `Gleanex.SSE`
    * chat is newline-delimited JSON, decoded by `Gleanex.NDJSON`

  ## Consuming a stream

  The response is delivered to the process that made the request, so the stream
  must be consumed in that same process, and only once.

  ## Examples

      {:ok, events} = Gleanex.Streaming.agent_run(config, %{agentId: "abc", input: %{}})

      for event <- events do
        case Gleanex.SSE.json_data(event) do
          {:ok, payload} -> IO.inspect(payload)
          {:error, _} -> :ok
        end
      end

      {:ok, chunks} = Gleanex.Streaming.chat(config, %{messages: messages})

      chunks
      |> Stream.flat_map(&get_in(&1, ["messages", Access.all(), "fragments"]))
      |> Enum.each(&IO.write/1)

  Failures before the first byte arrive as `{:error, %Gleanex.Error{}}`. A
  failure part way through a stream raises while the stream is being consumed,
  because by then a response has already been reported as successful.
  """

  alias Gleanex.Config
  alias Gleanex.Error
  alias Gleanex.HTTP
  alias Gleanex.NDJSON
  alias Gleanex.SSE

  @typedoc "A lazily consumed response body."
  @type stream :: Enumerable.t()

  @doc """
  Stream a chat response, one `ChatResponse` per element.

  Sets `stream: true` in the request body; anything you pass wins over that, so
  it can be turned back off if you want the buffered form.

  Bodies are returned as plain decoded maps rather than
  `Gleanex.Client.ChatResponse` structs, because each streamed line is a partial
  response and the struct's shape would imply more than has actually arrived.
  """
  @spec chat(Config.t(), map, keyword) :: {:ok, stream} | {:error, Error.t()}
  def chat(%Config{} = config, body, opts \\ []) do
    operation = operation(:chat, "/chat", Map.merge(%{stream: true}, body), opts)
    start(config, :client, operation, &NDJSON.decode/1)
  end

  @doc """
  Stream a Client API agent run as server-sent events.

  Calls `POST /agents/runs/stream`, the streaming counterpart of
  `Gleanex.Client.Agents.create_and_wait_run/2`.
  """
  @spec agent_run(Config.t(), map, keyword) :: {:ok, stream} | {:error, Error.t()}
  def agent_run(%Config{} = config, body, opts \\ []) do
    operation = operation(:agent_run, "/agents/runs/stream", body, opts)
    start(config, :client, operation, &SSE.decode/1)
  end

  @doc """
  Stream a Platform API agent run as server-sent events.

  Calls `POST /agents/{agent_id}/runs` with `stream` set, the streaming form of
  `Gleanex.Platform.Agents.create_run/3`.
  """
  @spec platform_agent_run(Config.t(), String.t(), map, keyword) ::
          {:ok, stream} | {:error, Error.t()}
  def platform_agent_run(%Config{} = config, agent_id, body, opts \\ []) do
    body = Map.merge(%{stream: true}, body)
    operation = operation(:platform_agent_run, "/agents/#{agent_id}/runs", body, opts)
    start(config, :platform, operation, &SSE.decode/1)
  end

  # The same shape `Gleanex.HTTP.request/1` takes from generated operations.
  # These endpoints are all JSON posts, so only the name, path and body differ.
  defp operation(name, url, body, opts) do
    %{
      call: {__MODULE__, name},
      url: url,
      method: :post,
      body: body,
      request: [{"application/json", :map}],
      opts: opts
    }
  end

  defp start(config, api, operation, decoder) do
    call = Map.get(operation, :call)

    with :ok <- Config.check_scope(config, api) do
      operation
      |> put_streaming_options()
      |> then(&HTTP.build_request(config, api, &1))
      |> Req.request()
      |> handle(decoder, call)
    end
  end

  # `into: :self` makes Req deliver the body to this process in chunks instead of
  # buffering it, and `decode_body: false` stops it trying to parse a body it
  # has not got yet. Retries are left off: Req cannot replay a response whose
  # chunks may already have been handed to the caller.
  defp put_streaming_options(operation) do
    opts = Map.get(operation, :opts, [])
    streaming = [into: :self, decode_body: false]

    opts =
      opts
      |> Keyword.put(:req_options, Keyword.merge(Keyword.get(opts, :req_options, []), streaming))
      |> Keyword.put_new(:retry, Gleanex.Retry.disabled())

    Map.put(operation, :opts, opts)
  end

  defp handle({:ok, %Req.Response{status: status, body: body}}, decoder, _call)
       when status in 200..299 do
    {:ok, decoder.(body)}
  end

  defp handle({:ok, %Req.Response{} = response}, _decoder, call) do
    {:error, response |> collect_error_body() |> Error.from_response(call)}
  end

  defp handle({:error, exception}, _decoder, call) do
    {:error, Error.from_exception(exception, call)}
  end

  # An unsuccessful response is streamed too, so its body has to be drained
  # before there is anything to report.
  #
  # The is_binary guard is defensive and never fires today: `into: :self` is
  # merged last in put_streaming_options, so a caller cannot turn it off, and Req
  # hands back a Req.Response.Async for every status including errors. It stays
  # because draining is the only branch that would crash if that ever changed.
  defp collect_error_body(%Req.Response{body: body} = response) do
    collected =
      if is_binary(body), do: body, else: body |> Enum.to_list() |> IO.iodata_to_binary()

    case JSON.decode(collected) do
      {:ok, decoded} -> %{response | body: decoded}
      {:error, _reason} -> %{response | body: collected}
    end
  end
end
