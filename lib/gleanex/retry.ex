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
  `HEAD`, which would leave nearly every Glean call unretried. Method is
  therefore no guide to whether retrying is safe, and the API is used instead.

  A fresh `%Gleanex.Retry{}` leaves `retry` as `:default`, which resolves per
  API when the request is built:

    * Client, Platform and Admin get `:transient`, retrying HTTP 408, 429, 500,
      502, 503 and 504 along with transport errors such as timeouts, refused
      connections and closed sockets.
    * Indexing gets `unsent?/2`, retrying only what Glean cannot have acted on.

  ## Why Indexing is narrower

  Indexing is writes. A 500 or a timeout says the response did not arrive, not
  that the write did not happen, so retrying one can index the same batch twice
  or replay a `/bulkindex` page against an upload that already took it. Only the
  failures that say the request was never processed are worth retrying there,
  which is what `unsent?/2` is.

  This splits by API rather than by operation, so it is a rough line rather than
  an exact one. Non-idempotent writes elsewhere, `createannouncement` being the
  clearest, still get `:transient`. Set `retry` yourself for those.

  ## Examples

      # No retries at all.
      Gleanex.Retry.disabled()

      # More attempts, fixed one second delay. Still resolves per API.
      %Gleanex.Retry{max_retries: 5, delay: fn _count -> 1_000 end}

      # The same condition everywhere, whatever the API.
      %Gleanex.Retry{retry: :transient}

      # Treat a Client API write as carefully as an Indexing one.
      %Gleanex.Retry{retry: &Gleanex.Retry.unsent?/2}

      # Only retry rate limits, never server errors.
      %Gleanex.Retry{retry: fn _req, %{status: status} -> status == 429 end}

  """

  @type t :: %__MODULE__{
          retry:
            :default
            | :transient
            | :safe_transient
            | false
            | (term, term -> boolean | {:delay, pos_integer}),
          max_retries: non_neg_integer,
          delay: nil | (non_neg_integer -> non_neg_integer),
          log_level: Logger.level() | false
        }

  defstruct retry: :default,
            max_retries: 3,
            delay: nil,
            log_level: :warning

  @doc """
  A policy that never retries.
  """
  @spec disabled() :: t
  def disabled, do: %__MODULE__{retry: false}

  @doc """
  Whether a failure says the request was never processed.

  The retry condition Indexing gets by default. True only for the failures that
  rule out Glean having acted on the request:

    * HTTP 408, where the server gave up waiting for the request
    * HTTP 429, refused before it was handled
    * HTTP 503, refused because the service was not taking work
    * an HTTP/2 stream the server declined to process, or a request that never
      got a connection

  Everything else, HTTP 500, 502 and 504 included, is false: the response is
  missing, which says nothing about whether the write landed. Transport timeouts
  are the same, and are the case most likely to be a write that succeeded.
  """
  @spec unsent?(term, term) :: boolean
  def unsent?(request, response_or_exception)

  def unsent?(_request, %Req.Response{status: status}), do: status in [408, 429, 503]

  def unsent?(_request, %Req.HTTPError{protocol: :http2, reason: reason}),
    do: reason in [:unprocessed, :pool_not_available]

  def unsent?(_request, _other), do: false

  @doc """
  The condition `:default` resolves to for `api`.

      iex> Gleanex.Retry.condition_for(:client)
      :transient
      iex> Gleanex.Retry.condition_for(:indexing)
      &Gleanex.Retry.unsent?/2

  """
  @spec condition_for(Gleanex.Config.api()) :: :transient | (term, term -> boolean)
  def condition_for(:indexing), do: &__MODULE__.unsent?/2
  def condition_for(_api), do: :transient

  @doc """
  Translate the policy into `Req` request options.

  `api` decides what a `retry` of `:default` means; see `condition_for/1`. Any
  other value is passed through, so setting one yourself applies everywhere.

  `:retry_delay` is deliberately omitted when `delay` is `nil`: that is what
  makes `Req` fall back to `Retry-After` plus exponential backoff with jitter.
  `Req` honours `Retry-After` on 429 and 503 whatever the condition is, so a
  narrower one still backs off when Glean asks it to.
  """
  @spec to_req_options(t, Gleanex.Config.api()) :: keyword
  def to_req_options(policy, api \\ :client)

  def to_req_options(%__MODULE__{retry: false}, _api), do: [retry: false]

  def to_req_options(%__MODULE__{retry: :default} = policy, api) do
    to_req_options(%{policy | retry: condition_for(api)}, api)
  end

  def to_req_options(%__MODULE__{} = policy, _api) do
    base = [
      retry: policy.retry,
      max_retries: policy.max_retries,
      retry_log_level: policy.log_level
    ]

    if policy.delay, do: [{:retry_delay, policy.delay} | base], else: base
  end
end
