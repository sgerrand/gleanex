defmodule Gleanex.Error do
  @moduledoc """
  Every way a Glean call can fail, in one struct.

  Operations return `{:ok, result}` or `{:error, %Gleanex.Error{}}` and never
  both. Match on `:reason` to tell failures apart:

    * `:config` - bad or missing settings, raised or returned before any request
      is sent. Missing token, unresolvable domain, wrong token scope.
    * `:transport` - the request never got a response: timeout, refused
      connection, TLS failure. `exception` holds the underlying error.
    * `:rate_limited` - HTTP 429. `retry_after` holds the header value in
      seconds when Glean sent one.
    * `:problem_detail` - the response carried an RFC 7807 body, parsed into
      `problem`.
    * `:http` - any other unsuccessful status, with the decoded `body`.

  ## Examples

      case Gleanex.Client.Search.search(body, config: config) do
        {:ok, results} -> results
        {:error, %Gleanex.Error{reason: :rate_limited, retry_after: seconds}} -> back_off(seconds)
        {:error, %Gleanex.Error{reason: :problem_detail, problem: problem}} -> Logger.error(problem.detail)
        {:error, error} -> raise error
      end

  """

  alias Gleanex.ProblemDetail

  @type reason :: :config | :transport | :rate_limited | :problem_detail | :http

  @type t :: %__MODULE__{
          reason: reason,
          message: String.t(),
          status: integer | nil,
          body: term,
          problem: ProblemDetail.t() | nil,
          retry_after: integer | nil,
          exception: Exception.t() | nil,
          operation: {module, atom} | nil
        }

  defexception [
    :reason,
    :message,
    :status,
    :body,
    :problem,
    :retry_after,
    :exception,
    :operation
  ]

  @impl true
  def message(%__MODULE__{message: message}), do: message

  @doc """
  A configuration failure. Raised by `Gleanex.new/1`, returned by scope checks.
  """
  @spec config(String.t()) :: t
  def config(message) when is_binary(message) do
    %__MODULE__{reason: :config, message: message}
  end

  @doc """
  Wrap an unsuccessful response.

  `operation` is the `{module, function}` pair the generated code reports, used
  only to make the message readable.
  """
  @spec from_response(Req.Response.t(), {module, atom} | nil) :: t
  def from_response(%Req.Response{status: status, body: body} = response, operation \\ nil) do
    problem = ProblemDetail.parse(body)
    retry_after = retry_after(response)

    reason =
      cond do
        status == 429 -> :rate_limited
        problem -> :problem_detail
        true -> :http
      end

    %__MODULE__{
      reason: reason,
      message: response_message(reason, status, problem, retry_after, operation),
      status: status,
      body: body,
      problem: problem,
      retry_after: retry_after,
      operation: operation
    }
  end

  @doc """
  Wrap a transport level exception.
  """
  @spec from_exception(Exception.t(), {module, atom} | nil) :: t
  def from_exception(exception, operation \\ nil) do
    %__MODULE__{
      reason: :transport,
      message: "#{describe(operation)}failed to reach Glean: #{Exception.message(exception)}",
      exception: exception,
      operation: operation
    }
  end

  defp response_message(:rate_limited, status, problem, retry_after, operation) do
    wait =
      case retry_after do
        nil -> ""
        seconds -> ", retry after #{seconds}s"
      end

    "#{describe(operation)}rate limited by Glean (HTTP #{status}#{wait})" <>
      detail_suffix(problem)
  end

  defp response_message(:problem_detail, status, problem, _retry_after, operation) do
    "#{describe(operation)}Glean returned HTTP #{status}: #{ProblemDetail.message(problem)}"
  end

  defp response_message(:http, status, _problem, _retry_after, operation) do
    "#{describe(operation)}Glean returned HTTP #{status}"
  end

  defp detail_suffix(nil), do: ""
  defp detail_suffix(problem), do: ": " <> ProblemDetail.message(problem)

  defp describe(nil), do: ""
  defp describe({module, function}), do: "#{inspect(module)}.#{function}/n: "

  defp retry_after(%Req.Response{} = response) do
    response
    |> Req.Response.get_header("retry-after")
    |> List.first()
    |> parse_retry_after()
  end

  defp parse_retry_after(nil), do: nil

  defp parse_retry_after(value) when is_binary(value) do
    case Integer.parse(value) do
      {seconds, ""} when seconds >= 0 -> seconds
      _ -> nil
    end
  end
end
