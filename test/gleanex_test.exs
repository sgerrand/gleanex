defmodule GleanexTest do
  use ExUnit.Case, async: true

  doctest Gleanex

  setup context do
    Req.Test.set_req_test_from_context(context)

    %{
      config:
        Gleanex.new(
          domain: "acme",
          token: "secret",
          req_options: [plug: {Req.Test, GleanexTopLevelStub}]
        )
    }
  end

  describe "search/3" do
    test "sends the query as the request body", %{config: config} do
      Req.Test.stub(GleanexTopLevelStub, fn conn ->
        assert conn.request_path == "/rest/api/v1/search"
        {:ok, body, conn} = Plug.Conn.read_body(conn)
        assert JSON.decode!(body) == %{"query" => "holidays"}

        Req.Test.json(conn, %{trackingToken: "t", results: []})
      end)

      assert {:ok, %Gleanex.Client.SearchResponse{trackingToken: "t"}} =
               Gleanex.search(config, "holidays")
    end

    test "merges extra body fields", %{config: config} do
      Req.Test.stub(GleanexTopLevelStub, fn conn ->
        {:ok, body, conn} = Plug.Conn.read_body(conn)
        assert JSON.decode!(body) == %{"query" => "holidays", "pageSize" => 50}

        Req.Test.json(conn, %{})
      end)

      assert {:ok, _} = Gleanex.search(config, "holidays", body: %{pageSize: 50})
    end

    test "surfaces errors like any other operation", %{config: config} do
      Req.Test.stub(GleanexTopLevelStub, fn conn ->
        conn |> Plug.Conn.put_status(401) |> Req.Test.json(%{title: "Unauthorized"})
      end)

      assert {:error, %Gleanex.Error{status: 401}} = Gleanex.search(config, "holidays")
    end
  end

  describe "chat/3" do
    test "wraps the message in a single USER message", %{config: config} do
      Req.Test.stub(GleanexTopLevelStub, fn conn ->
        assert conn.request_path == "/rest/api/v1/chat"
        {:ok, body, conn} = Plug.Conn.read_body(conn)

        assert %{"messages" => [%{"author" => "USER", "fragments" => [%{"text" => "hi?"}]}]} =
                 JSON.decode!(body)

        Req.Test.json(conn, %{chatId: "c1"})
      end)

      assert {:ok, %Gleanex.Client.ChatResponse{chatId: "c1"}} = Gleanex.chat(config, "hi?")
    end

    test "merges extra body fields such as the agent to use", %{config: config} do
      Req.Test.stub(GleanexTopLevelStub, fn conn ->
        {:ok, body, conn} = Plug.Conn.read_body(conn)
        assert %{"agentId" => "abc", "messages" => [_]} = JSON.decode!(body)

        Req.Test.json(conn, %{})
      end)

      assert {:ok, _} = Gleanex.chat(config, "hi?", body: %{agentId: "abc"})
    end
  end
end
