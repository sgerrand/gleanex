defmodule Gleanex.Error do
  @moduledoc """
  Every way a Glean call can fail, in one struct.

  Operations return `{:ok, result}` or `{:error, %Gleanex.Error{}}` and never
  both. Match on `:reason` to tell failures apart:

    * `:config` - bad or missing settings, raised or returned before any request
      is sent. Missing token, unresolvable domain, wrong token scope.
    * `:transport` - the request never got a response: timeout, refused
      connection, TLS failure. `exception` holds the underlying error.
    * `:rate_limited` - HTTP 429. `retry_after` holds how many seconds to wait,
      when Glean sent a `Retry-After` header. A header giving a date rather than
      a delay is converted, so this is always seconds.
    * `:problem_detail` - the response carried an RFC 7807 body, parsed into
      `problem`.
    * `:http` - any other unsuccessful status, with the decoded `body`.
    * `:usage` - the library was driven in a way that cannot work, such as
      consuming a stream from a process that did not make the request. Always
      raised rather than returned: the call itself succeeded.

  ## Examples

      case Gleanex.Client.Search.search(body, config: config) do
        {:ok, results} -> results
        {:error, %Gleanex.Error{reason: :rate_limited, retry_after: seconds}} -> back_off(seconds)
        {:error, %Gleanex.Error{reason: :problem_detail, problem: problem}} -> Logger.error(problem.detail)
        {:error, error} -> raise error
      end

  """

  alias Gleanex.ProblemDetail

  @type reason :: :config | :transport | :rate_limited | :problem_detail | :http | :usage

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
  A misuse of the library, caught before it turns into something confusing.
  """
  @spec usage(String.t()) :: t
  def usage(message) when is_binary(message) do
    %__MODULE__{reason: :usage, message: message}
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
  defp describe({module, function}), do: "#{inspect(module)}.#{function}: "

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
      {_negative, ""} -> nil
      _ -> parse_http_date(value)
    end
  end

  # RFC 9110 lets `Retry-After` carry either a delay in seconds or a date, and
  # both forms reach callers here as seconds so there is only one thing to back
  # off on.
  #
  # Only the IMF-fixdate form is read, because that is the only one a server is
  # allowed to send. The two obsolete formats a recipient may also see are rare
  # enough that guessing at them is worse than reporting nothing.
  #
  # The delay is measured against this machine's clock. A date already in the
  # past, which is what a clock running fast looks like, becomes 0: retry now.
  @months ~w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)

  defp parse_http_date(value) do
    with [_, day, month, year, hour, minute, second] <-
           Regex.run(
             ~r/^[A-Za-z]{3}, (\d{2}) ([A-Za-z]{3}) (\d{4}) (\d{2}):(\d{2}):(\d{2}) GMT$/,
             value
           ),
         {:ok, month} <- month_number(month),
         {:ok, datetime} <-
           NaiveDateTime.new(
             String.to_integer(year),
             month,
             String.to_integer(day),
             String.to_integer(hour),
             String.to_integer(minute),
             String.to_integer(second)
           ) do
      datetime
      |> DateTime.from_naive!("Etc/UTC")
      |> DateTime.diff(DateTime.utc_now())
      |> max(0)
    else
      _ -> nil
    end
  end

  defp month_number(month) do
    case Enum.find_index(@months, &(&1 == month)) do
      nil -> :error
      index -> {:ok, index + 1}
    end
  end
end
