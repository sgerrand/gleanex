defmodule Gleanex.HTTPTest do
  use ExUnit.Case, async: true

  alias Gleanex.Admin.SupportDatasources
  alias Gleanex.Client.SupportSearch
  alias Gleanex.Error
  alias Gleanex.Indexing.SupportDocuments
  alias Gleanex.Support.Schemas.Person
  alias Gleanex.Support.Schemas.Result
  alias Gleanex.Support.Schemas.SearchResponse

  setup :set_stub

  describe "request building" do
    test "sends a bearer token and a user agent", %{config: config} do
      Req.Test.stub(GleanexStub, fn conn ->
        assert Plug.Conn.get_req_header(conn, "authorization") == ["Bearer secret"]
        assert [user_agent] = Plug.Conn.get_req_header(conn, "user-agent")
        assert user_agent =~ ~r{^gleanex/}

        Req.Test.json(conn, %{})
      end)

      assert {:ok, _} = SupportSearch.search(%{query: "holidays"}, config: config)
    end

    test "resolves the Client API prefix", %{config: config} do
      Req.Test.stub(GleanexStub, fn conn ->
        assert conn.host == "acme-be.glean.com"
        assert conn.request_path == "/rest/api/v1/search"
        assert conn.method == "POST"

        Req.Test.json(conn, %{})
      end)

      assert {:ok, _} = SupportSearch.search(%{query: "holidays"}, config: config)
    end

    test "resolves the Indexing API prefix", %{indexing_config: config} do
      Req.Test.stub(GleanexStub, fn conn ->
        assert conn.request_path == "/api/index/v1/indexdocument"
        Req.Test.json(conn, %{})
      end)

      assert {:ok, _} = SupportDocuments.index_document(%{document: %{}}, config: config)
    end

    test "encodes the body as JSON", %{config: config} do
      Req.Test.stub(GleanexStub, fn conn ->
        assert ["application/json"] = Plug.Conn.get_req_header(conn, "content-type")
        {:ok, body, conn} = Plug.Conn.read_body(conn)
        assert JSON.decode!(body) == %{"query" => "holidays", "pageSize" => 10}

        Req.Test.json(conn, %{})
      end)

      assert {:ok, _} = SupportSearch.search(%{query: "holidays", pageSize: 10}, config: config)
    end

    test "accepts a schema struct as the body, which is what the specs declare", %{config: config} do
      Req.Test.stub(GleanexStub, fn conn ->
        {:ok, body, conn} = Plug.Conn.read_body(conn)

        # Unset struct fields are dropped rather than sent as nulls.
        assert JSON.decode!(body) == %{"query" => "holidays", "pageSize" => 10}

        Req.Test.json(conn, %{})
      end)

      request = %Gleanex.Client.SearchRequest{query: "holidays", pageSize: 10}
      assert {:ok, _} = SupportSearch.search(request, config: config)
    end

    test "interpolates path parameters and encodes query parameters", %{config: config} do
      Req.Test.stub(GleanexStub, fn conn ->
        assert conn.request_path == "/rest/api/v1/datasource/jira-1/credentialstatus"
        assert conn.query_string == "verbose=true"

        Req.Test.json(conn, %{status: "ok"})
      end)

      assert {:ok, %{"status" => "ok"}} =
               SupportDatasources.credential_status("jira-1", config: config, verbose: true)
    end

    test "omits the query string when there are no query parameters", %{config: config} do
      Req.Test.stub(GleanexStub, fn conn ->
        assert conn.query_string == ""
        Req.Test.json(conn, %{})
      end)

      assert {:ok, _} = SupportDatasources.credential_status("jira-1", config: config)
    end

    test "per-call req_options override the config's", %{config: config} do
      config = %{
        config
        | req_options: Keyword.put(config.req_options, :headers, [{"x-from", "config"}])
      }

      Req.Test.stub(GleanexStub, fn conn ->
        assert Plug.Conn.get_req_header(conn, "x-from") == ["call"]
        Req.Test.json(conn, %{})
      end)

      assert {:ok, _} =
               SupportSearch.search(%{query: "q"},
                 config: config,
                 req_options: [headers: [{"x-from", "call"}]]
               )
    end
  end

  describe "response decoding" do
    test "builds the struct named by the operation's response table", %{config: config} do
      Req.Test.stub(GleanexStub, fn conn ->
        Req.Test.json(conn, %{
          trackingToken: "token-1",
          hasMoreResults: true,
          results: [
            %{
              title: "Holidays",
              url: "https://example.com",
              author: %{name: "Ada", email: "ada@example.com"}
            }
          ]
        })
      end)

      assert {:ok, %SearchResponse{} = response} =
               SupportSearch.search(%{query: "holidays"}, config: config)

      assert response.trackingToken == "token-1"
      assert response.hasMoreResults == true
      assert [%Result{title: "Holidays", author: %Person{name: "Ada"}}] = response.results
    end

    test "keeps unknown fields out of the struct rather than crashing", %{config: config} do
      Req.Test.stub(GleanexStub, fn conn ->
        Req.Test.json(conn, %{trackingToken: "token-1", brandNewField: "surprise"})
      end)

      assert {:ok, %SearchResponse{trackingToken: "token-1", results: []}} =
               SupportSearch.search(%{query: "holidays"}, config: config)
    end

    test "returns the raw body when the operation declares no typed response", %{config: config} do
      Req.Test.stub(GleanexStub, fn conn -> Req.Test.json(conn, %{"anything" => 1}) end)

      assert {:ok, %{"anything" => 1}} =
               SupportDatasources.credential_status("jira-1", config: config)
    end

    test "an empty 204 body decodes to nil", %{indexing_config: config} do
      Req.Test.stub(GleanexStub, fn conn -> Plug.Conn.send_resp(conn, 204, "") end)

      assert {:ok, nil} = SupportDocuments.index_document(%{document: %{}}, config: config)
    end
  end

  describe "error handling" do
    test "parses an RFC 7807 problem detail", %{config: config} do
      Req.Test.stub(GleanexStub, fn conn ->
        conn
        |> Plug.Conn.put_status(403)
        |> Req.Test.json(%{
          title: "Forbidden",
          detail: "The token lacks the required scope",
          code: "INSUFFICIENT_SCOPE",
          status: 403
        })
      end)

      assert {:error, %Error{reason: :problem_detail} = error} =
               SupportSearch.search(%{query: "q"}, config: config)

      assert error.status == 403
      assert error.problem.code == "INSUFFICIENT_SCOPE"
      assert error.problem.title == "Forbidden"
      assert Exception.message(error) =~ "Forbidden: The token lacks the required scope"
      assert Exception.message(error) =~ "SupportSearch.search"
    end

    test "reports rate limits with the Retry-After value", %{config: config} do
      Req.Test.stub(GleanexStub, fn conn ->
        conn
        |> Plug.Conn.put_resp_header("retry-after", "42")
        |> Plug.Conn.put_status(429)
        |> Req.Test.json(%{title: "Too Many Requests"})
      end)

      config = %{config | retry: Gleanex.Retry.disabled()}

      assert {:error, %Error{reason: :rate_limited, retry_after: 42, status: 429} = error} =
               SupportSearch.search(%{query: "q"}, config: config)

      assert Exception.message(error) =~ "retry after 42s"
    end

    test "falls back to a plain HTTP error for bodies that are not problem details", %{
      config: config
    } do
      Req.Test.stub(GleanexStub, fn conn ->
        conn |> Plug.Conn.put_status(418) |> Req.Test.json(%{"unexpected" => true})
      end)

      assert {:error, %Error{reason: :http, status: 418, body: %{"unexpected" => true}}} =
               SupportSearch.search(%{query: "q"}, config: config)
    end

    test "wraps transport failures", %{config: config} do
      Req.Test.stub(GleanexStub, fn conn ->
        Req.Test.transport_error(conn, :econnrefused)
      end)

      config = %{config | retry: Gleanex.Retry.disabled()}

      assert {:error, %Error{reason: :transport} = error} =
               SupportSearch.search(%{query: "q"}, config: config)

      assert Exception.message(error) =~ "failed to reach Glean"
    end

    test "refuses a scope mismatch before sending anything", %{config: config} do
      Req.Test.stub(GleanexStub, fn _conn ->
        flunk("request should never have been sent")
      end)

      assert {:error, %Error{reason: :config, message: message}} =
               SupportDocuments.index_document(%{document: %{}}, config: config)

      assert message =~ "holds a client token"
    end

    test "rejects a :config option that is not a Gleanex.Config" do
      assert {:error, %Error{reason: :config, message: message}} =
               SupportSearch.search(%{query: "q"}, config: %{domain: "acme"})

      assert message =~ "expected :config to be a Gleanex.Config"
    end
  end

  describe "retries" do
    test "retries a failed POST and succeeds", %{config: config} do
      counter = start_counter()

      Req.Test.stub(GleanexStub, fn conn ->
        case bump(counter) do
          1 -> conn |> Plug.Conn.put_status(503) |> Req.Test.json(%{title: "Unavailable"})
          _ -> Req.Test.json(conn, %{trackingToken: "after-retry"})
        end
      end)

      config = %{config | retry: %Gleanex.Retry{delay: fn _ -> 0 end, log_level: false}}

      assert {:ok, %SearchResponse{trackingToken: "after-retry"}} =
               SupportSearch.search(%{query: "q"}, config: config)

      assert value(counter) == 2
    end

    test "gives up after max_retries and returns the last error", %{config: config} do
      counter = start_counter()

      Req.Test.stub(GleanexStub, fn conn ->
        bump(counter)
        conn |> Plug.Conn.put_status(500) |> Req.Test.json(%{title: "Boom"})
      end)

      config = %{
        config
        | retry: %Gleanex.Retry{max_retries: 2, delay: fn _ -> 0 end, log_level: false}
      }

      assert {:error, %Error{status: 500}} = SupportSearch.search(%{query: "q"}, config: config)
      assert value(counter) == 3
    end

    test "a disabled policy sends exactly one request", %{config: config} do
      counter = start_counter()

      Req.Test.stub(GleanexStub, fn conn ->
        bump(counter)
        conn |> Plug.Conn.put_status(500) |> Req.Test.json(%{title: "Boom"})
      end)

      config = %{config | retry: Gleanex.Retry.disabled()}

      assert {:error, %Error{status: 500}} = SupportSearch.search(%{query: "q"}, config: config)
      assert value(counter) == 1
    end
  end

  describe "telemetry" do
    test "emits a span with the API and operation", %{config: config} do
      Req.Test.stub(GleanexStub, fn conn -> Req.Test.json(conn, %{}) end)

      handler = "test-#{inspect(self())}"
      parent = self()

      :telemetry.attach_many(
        handler,
        [[:gleanex, :request, :start], [:gleanex, :request, :stop]],
        fn event, measurements, metadata, _ ->
          send(parent, {:telemetry, event, measurements, metadata})
        end,
        nil
      )

      on_exit(fn -> :telemetry.detach(handler) end)

      assert {:ok, _} = SupportSearch.search(%{query: "q"}, config: config)

      assert_receive {:telemetry, [:gleanex, :request, :start], _, %{api: :client} = metadata}
      assert metadata.operation == {SupportSearch, :search}
      assert metadata.method == :post
      assert metadata.url == "/search"

      assert_receive {:telemetry, [:gleanex, :request, :stop], %{duration: _}, %{status: 200}}
    end
  end

  defp set_stub(context) do
    Req.Test.set_req_test_from_context(context)

    base = [token: "secret", domain: "acme", req_options: [plug: {Req.Test, GleanexStub}]]

    %{
      config: Gleanex.new(base),
      indexing_config: Gleanex.new([{:scope, :indexing} | base])
    }
  end

  defp start_counter do
    {:ok, agent} = Agent.start_link(fn -> 0 end)
    agent
  end

  defp bump(agent), do: Agent.get_and_update(agent, fn count -> {count + 1, count + 1} end)
  defp value(agent), do: Agent.get(agent, & &1)
end
