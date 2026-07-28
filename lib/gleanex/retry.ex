defmodule Gleanex.Retry do
  @moduledoc """
  Retry policy for Glean requests.

  This is a thin policy struct that translates into `Req` retry options. `Req`
  already implements exponential backoff with jitter and honours the
  `Retry-After` header on HTTP 429 and 503 responses, so there is nothing to
  reimplement here.

  ## Defaults

  Glean's APIs are overwhelmingly `POST`, including reads such as `/search` and
  `/chat`. `Req`'s default policy (`:safe_transient`) only retries `GET` and
  `HEAD`, which would leave nearly every Glean call unretried, so the default
  here is `:transient`.

  Retried conditions come from `Req`: HTTP 408, 429, 500, 502, 503 and 504, and
  transport errors such as timeouts, refused connections and closed sockets.

  ## Examples

      # No retries at all.
      Gleanex.Retry.disabled()

      # More attempts, fixed one second delay.
      %Gleanex.Retry{max_retries: 5, delay: fn _count -> 1_000 end}

      # Only retry rate limits, never server errors.
      %Gleanex.Retry{retry: fn _req, %{status: status} -> status == 429 end}

  """

  @type t :: %__MODULE__{
          retry:
            :transient | :safe_transient | false | (term, term -> boolean | {:delay, pos_integer}),
          max_retries: non_neg_integer,
          delay: nil | (non_neg_integer -> non_neg_integer),
          log_level: Logger.level() | false
        }

  defstruct retry: :transient,
            max_retries: 3,
            delay: nil,
            log_level: :warning

  @doc """
  A policy that never retries.
  """
  @spec disabled() :: t
  def disabled, do: %__MODULE__{retry: false}

  @doc """
  Translate the policy into `Req` request options.

  `:retry_delay` is deliberately omitted when `delay` is `nil`: that is what
  makes `Req` fall back to `Retry-After` plus exponential backoff with jitter.
  """
  @spec to_req_options(t) :: keyword
  def to_req_options(%__MODULE__{retry: false}), do: [retry: false]

  def to_req_options(%__MODULE__{} = policy) do
    base = [
      retry: policy.retry,
      max_retries: policy.max_retries,
      retry_log_level: policy.log_level
    ]

    if policy.delay, do: [{:retry_delay, policy.delay} | base], else: base
  end
end
