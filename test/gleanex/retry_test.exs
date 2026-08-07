defmodule Gleanex.RetryTest do
  use ExUnit.Case, async: true

  alias Gleanex.Retry

  describe "defaults" do
    test "retries transiently, which covers the POSTs Glean's reads are" do
      # Req's own default, :safe_transient, retries only GET and HEAD. Glean
      # serves /search and /chat over POST, so that default would leave nearly
      # every call unretried.
      assert %Retry{retry: :transient, max_retries: 3, delay: nil, log_level: :warning} = %Retry{}
    end
  end

  describe "disabled/0" do
    test "builds a policy that never retries" do
      assert Retry.disabled().retry == false
    end
  end

  describe "to_req_options/1" do
    test "translates the default policy" do
      options = Retry.to_req_options(%Retry{})

      assert options[:retry] == :transient
      assert options[:max_retries] == 3
      assert options[:retry_log_level] == :warning
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
