defmodule Gleanex.RetryTest do
  use ExUnit.Case, async: true

  alias Gleanex.Retry

  doctest Gleanex.Retry

  describe "defaults" do
    test "leaves the condition to be resolved per API" do
      # Req's own default, :safe_transient, retries only GET and HEAD. Glean
      # serves /search and /chat over POST, so method cannot decide this and the
      # API does instead; see condition_for/1.
      assert %Retry{retry: :default, max_retries: 3, delay: nil, log_level: :warning} = %Retry{}
    end
  end

  describe "condition_for/1" do
    test "reads and writes alike get :transient outside Indexing" do
      assert Retry.condition_for(:client) == :transient
      assert Retry.condition_for(:platform) == :transient
      assert Retry.condition_for(:admin) == :transient
    end

    test "Indexing only retries what Glean cannot have acted on" do
      assert Retry.condition_for(:indexing) == (&Retry.unsent?/2)
    end
  end

  describe "unsent?/2" do
    test "true for the statuses that say the request was not processed" do
      for status <- [408, 429, 503] do
        assert Retry.unsent?(:request, %Req.Response{status: status}),
               "expected #{status} to be retryable for a write"
      end
    end

    test "false for the statuses that leave a write's fate unknown" do
      # The response is missing. That says nothing about whether Glean applied
      # the write, so retrying can index the same batch twice.
      for status <- [500, 502, 504] do
        refute Retry.unsent?(:request, %Req.Response{status: status}),
               "expected #{status} not to be retryable for a write"
      end
    end

    test "false for a success, which never reaches the retry step anyway" do
      refute Retry.unsent?(:request, %Req.Response{status: 200})
    end

    test "true for an HTTP/2 stream the server never processed" do
      for reason <- [:unprocessed, :pool_not_available] do
        assert Retry.unsent?(:request, %Req.HTTPError{protocol: :http2, reason: reason})
      end
    end

    test "false for a transport timeout, the likeliest write that did land" do
      refute Retry.unsent?(:request, %Req.TransportError{reason: :timeout})
    end

    test "false for a refused connection, which Req's :transient would retry" do
      refute Retry.unsent?(:request, %Req.TransportError{reason: :econnrefused})
    end

    test "false for an HTTP/2 error other than the unprocessed ones" do
      refute Retry.unsent?(:request, %Req.HTTPError{protocol: :http2, reason: :closed})
    end
  end

  describe "disabled/0" do
    test "builds a policy that never retries" do
      assert Retry.disabled().retry == false
    end
  end

  describe "to_req_options/2" do
    test "translates the default policy" do
      options = Retry.to_req_options(%Retry{})

      assert options[:retry] == :transient
      assert options[:max_retries] == 3
      assert options[:retry_log_level] == :warning
    end

    test "resolves :default against the API it is given" do
      assert Retry.to_req_options(%Retry{}, :client)[:retry] == :transient
      assert Retry.to_req_options(%Retry{}, :indexing)[:retry] == (&Retry.unsent?/2)
    end

    test "the API is only consulted for :default, never for a condition set by hand" do
      assert Retry.to_req_options(%Retry{retry: :transient}, :indexing)[:retry] == :transient
    end

    test "resolving :default keeps the rest of the policy" do
      options = Retry.to_req_options(%Retry{max_retries: 7, log_level: :error}, :indexing)

      assert options[:retry] == (&Retry.unsent?/2)
      assert options[:max_retries] == 7
      assert options[:retry_log_level] == :error
    end

    test "a disabled policy stays disabled against Indexing" do
      assert Retry.to_req_options(Retry.disabled(), :indexing) == [retry: false]
    end

    test "defaults to the Client condition when no API is given" do
      assert Retry.to_req_options(%Retry{}) == Retry.to_req_options(%Retry{}, :client)
    end

    test "omits :retry_delay when there is no delay, leaving Req's backoff in place" do
      # Req falls back to Retry-After plus exponential backoff with jitter only
      # when :retry_delay is absent. Passing nil would override that with nil.
      refute Keyword.has_key?(Retry.to_req_options(%Retry{}), :retry_delay)
    end

    test "passes a delay function through when there is one" do
      delay = fn _count -> 1_000 end
      options = Retry.to_req_options(%Retry{delay: delay})

      assert options[:retry_delay] == delay
    end

    test "collapses a disabled policy to retry: false and nothing else" do
      assert Retry.to_req_options(Retry.disabled()) == [retry: false]
    end

    test "a disabled policy ignores the other fields" do
      policy = %Retry{retry: false, max_retries: 9, delay: fn _ -> 1 end, log_level: :error}

      assert Retry.to_req_options(policy) == [retry: false]
    end

    test "carries a custom predicate through untouched" do
      predicate = fn _request, response -> response.status == 429 end
      options = Retry.to_req_options(%Retry{retry: predicate})

      assert options[:retry] == predicate
    end

    test "carries :safe_transient through for callers who want Req's default" do
      assert Retry.to_req_options(%Retry{retry: :safe_transient})[:retry] == :safe_transient
    end

    test "log_level: false silences Req's retry logging" do
      assert Retry.to_req_options(%Retry{log_level: false})[:retry_log_level] == false
    end

    test "max_retries: 0 is passed on rather than treated as disabled" do
      options = Retry.to_req_options(%Retry{max_retries: 0})

      assert options[:retry] == :transient
      assert options[:max_retries] == 0
    end
  end
end
