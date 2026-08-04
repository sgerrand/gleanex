defmodule Gleanex.LiveTest do
  @moduledoc """
  Smoke tests against a real Glean deployment.

  Everything else in the suite runs against `Req.Test` stubs, which prove the
  library does what Gleanex expects of it. Nothing there proves that is what
  Glean expects: a wrong path prefix, a mis-spelled auth header or a field name
  that does not match the description would pass every stubbed test.

  These run only when asked for, because they need credentials and reach the
  network:

      GLEAN_INSTANCE=mycompany GLEAN_API_TOKEN=... mix test --include integration

  ## Read-only, on purpose

  Only the Client API is exercised, and only its reads. The Indexing API writes
  to a real search index and a bulk upload replaces the previous batch, so a
  test that got it wrong could damage a live deployment. That surface is covered
  by stubs and by `Gleanex.Bulk`'s own tests instead.
  """

  # Not async: hitting a shared deployment, and the rate limit is shared too.
  use ExUnit.Case, async: false

  @moduletag :integration
  # Real requests, sometimes a cold agent. Generous rather than flaky.
  @moduletag timeout: 120_000

  alias Gleanex.Client.ChatResponse
  alias Gleanex.Client.Search
  alias Gleanex.Client.SearchResponse
  alias Gleanex.Client.SearchResult
  alias Gleanex.Error
  alias Gleanex.Pagination
  alias Gleanex.Streaming

  setup_all do
    token = System.get_env("GLEAN_API_TOKEN")
    instance = System.get_env("GLEAN_INSTANCE")

    if is_nil(token) or is_nil(instance) do
      flunk("""
      Integration tests need a real Glean deployment.

          GLEAN_INSTANCE=mycompany GLEAN_API_TOKEN=... mix test --include integration

      GLEAN_INSTANCE is the backend subdomain, usually your email domain without
      the TLD. The token must be a Client API token; an Indexing token will not
      work for these endpoints.
      """)
    end

    {:ok, config: Gleanex.new(domain: instance, token: token)}
  end

  describe "search" do
    test "answers a query and decodes into the generated structs", %{config: config} do
      assert {:ok, %SearchResponse{} = response} = Gleanex.search(config, "meeting")

      # Proves the response decoder found the fields the description declares.
      # A rename upstream would leave these nil.
      assert is_binary(response.trackingToken)
      assert is_list(response.results)

      # A deployment can legitimately return nothing for any given query, so the
      # shape of a result is only asserted when there is one.
      for %SearchResult{} = result <- Enum.take(response.results, 1) do
        assert is_binary(result.title) or is_nil(result.title)
        assert result.document != nil
      end
    end

    test "accepts the request options the description declares", %{config: config} do
      assert {:ok, %SearchResponse{} = response} =
               Search.search(%{query: "meeting", pageSize: 5}, config: config)

      assert length(response.results) <= 5
    end

    test "walks pages with a cursor", %{config: config} do
      pages =
        config
        |> Pagination.stream(&Search.search/2, %{query: "meeting", pageSize: 2})
        |> Enum.take(2)

      assert [%SearchResponse{} | _] = pages

      # One page means the deployment had nothing more to give, which is a valid
      # outcome; two means the cursor was accepted and followed.
      if length(pages) == 2 do
        [first, second] = pages
        assert first.trackingToken != nil
        assert %SearchResponse{} = second
      end
    end
  end

  describe "chat" do
    test "answers a question", %{config: config} do
      assert {:ok, %ChatResponse{} = response} =
               Gleanex.chat(config, "What is Glean?")

      assert is_list(response.messages)
      assert response.messages != []
    end

    test "streams an answer as it is written", %{config: config} do
      assert {:ok, stream} =
               Streaming.chat(config, %{
                 messages: [%{author: "USER", fragments: [%{text: "What is Glean?"}]}]
               })

      # Only the first few chunks: enough to prove the newline-delimited JSON
      # decoder handles what Glean actually sends, without waiting for a full
      # answer.
      chunks = Enum.take(stream, 3)

      assert chunks != [], "the stream produced nothing"
      assert Enum.all?(chunks, &is_map/1)
    end
  end

  describe "failures" do
    test "a rejected token is reported as an error rather than a crash", %{config: config} do
      bad = %{config | token: "definitely-not-a-valid-token"}

      assert {:error, %Error{} = error} = Gleanex.search(bad, "meeting")

      # Glean has answered 401 and 403 here at different times; either is a
      # correctly reported rejection.
      assert error.status in [401, 403],
             "expected the token to be rejected, got #{inspect(error)}"

      assert error.reason in [:http, :problem_detail]
      assert is_binary(Exception.message(error))
    end

    test "an unknown instance fails as a transport error", %{config: config} do
      unreachable = %{
        config
        | domain: "gleanex-instance-that-does-not-exist",
          retry: Gleanex.Retry.disabled()
      }

      assert {:error, %Error{reason: :transport}} = Gleanex.search(unreachable, "meeting")
    end
  end
end
