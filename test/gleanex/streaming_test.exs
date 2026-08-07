defmodule Gleanex.StreamingTest do
  use ExUnit.Case, async: true

  alias Gleanex.Error
  alias Gleanex.SSE.Event
  alias Gleanex.Streaming

  setup context do
    Req.Test.set_req_test_from_context(context)

    base = [token: "secret", domain: "acme", req_options: [plug: {Req.Test, GleanexStreamStub}]]

    %{
      config: Gleanex.new(base),
      indexing_config: Gleanex.new([{:scope, :indexing} | base])
    }
  end

  defp chunked(conn, chunks) do
    conn = Plug.Conn.send_chunked(conn, 200)

    Enum.reduce(chunks, conn, fn chunk, conn ->
      {:ok, conn} = Plug.Conn.chunk(conn, chunk)
      conn
    end)
  end

  describe "agent_run/3" do
    test "decodes server-sent events as they arrive", %{config: config} do
      Req.Test.stub(GleanexStreamStub, fn conn ->
        assert conn.request_path == "/rest/api/v1/agents/runs/stream"
        assert conn.method == "POST"

        chunked(conn, ["id: 1\nevent: message\ndata: {\"text\":\"hel", "lo\"}\n\n"])
      end)

      assert {:ok, stream} = Streaming.agent_run(config, %{agentId: "a"})

      assert [%Event{id: "1", event: "message"} = event] = Enum.to_list(stream)
      assert {:ok, %{"text" => "hello"}} = Gleanex.SSE.json_data(event)
    end
  end

  describe "platform_agent_run/4" do
    test "uses the Platform prefix and sets stream", %{config: config} do
      Req.Test.stub(GleanexStreamStub, fn conn ->
        assert conn.request_path == "/api/agents/abc/runs"

        {:ok, body, conn} = Plug.Conn.read_body(conn)
        assert %{"stream" => true, "input" => %{}} = JSON.decode!(body)

        chunked(conn, ["data: done\n\n"])
      end)

      assert {:ok, stream} = Streaming.platform_agent_run(config, "abc", %{input: %{}})
      assert [%Event{data: "done"}] = Enum.to_list(stream)
    end

    test "an explicit stream value wins over the default", %{config: config} do
      Req.Test.stub(GleanexStreamStub, fn conn ->
        {:ok, body, conn} = Plug.Conn.read_body(conn)
        assert %{"stream" => false} = JSON.decode!(body)
        chunked(conn, [])
      end)

      assert {:ok, _stream} = Streaming.platform_agent_run(config, "abc", %{stream: false})
    end
  end

  describe "chat/3" do
    test "sets stream and decodes newline-delimited JSON", %{config: config} do
      Req.Test.stub(GleanexStreamStub, fn conn ->
        assert conn.request_path == "/rest/api/v1/chat"

        {:ok, body, conn} = Plug.Conn.read_body(conn)
        assert %{"stream" => true, "messages" => []} = JSON.decode!(body)

        chunked(conn, [~s({"messages":[{"fragments":["one"]}]}\n{"mess), ~s(ages":[]}\n)])
      end)

      assert {:ok, stream} = Streaming.chat(config, %{messages: []})

      assert [%{"messages" => [%{"fragments" => ["one"]}]}, %{"messages" => []}] =
               Enum.to_list(stream)
    end

    test "is lazy: only the chunks taken are decoded", %{config: config} do
      Req.Test.stub(GleanexStreamStub, fn conn ->
        chunked(conn, [~s({"a":1}\n), ~s({"a":2}\n)])
      end)

      assert {:ok, stream} = Streaming.chat(config, %{messages: []})
      assert [%{"a" => 1}] = Enum.take(stream, 1)
    end
  end

  describe "failures" do
    test "an error status is drained and reported before streaming starts", %{config: config} do
      Req.Test.stub(GleanexStreamStub, fn conn ->
        conn
        |> Plug.Conn.put_status(403)
        |> Req.Test.json(%{title: "Forbidden", code: "NO_SCOPE"})
      end)

      assert {:error, %Error{reason: :problem_detail, status: 403} = error} =
               Streaming.agent_run(config, %{})

      assert error.problem.code == "NO_SCOPE"
    end

    test "a non-JSON error body is reported as a plain HTTP error", %{config: config} do
      Req.Test.stub(GleanexStreamStub, fn conn ->
        conn |> Plug.Conn.put_status(502) |> Plug.Conn.send_resp(502, "upstream is down")
      end)

      assert {:error, %Error{reason: :http, status: 502, body: "upstream is down"}} =
               Streaming.agent_run(config, %{})
    end

    test "transport failures are wrapped", %{config: config} do
      Req.Test.stub(GleanexStreamStub, fn conn ->
        Req.Test.transport_error(conn, :econnrefused)
      end)

      assert {:error, %Error{reason: :transport}} = Streaming.agent_run(config, %{})
    end

    test "an indexing token cannot start a client stream", %{indexing_config: config} do
      Req.Test.stub(GleanexStreamStub, fn _conn -> flunk("should not have been sent") end)

      assert {:error, %Error{reason: :config, message: message}} =
               Streaming.chat(config, %{messages: []})

      assert message =~ "holds an indexing token"
    end
  end

  describe "stream ownership" do
    test "consuming from another process raises instead of waiting", %{config: config} do
      Req.Test.stub(GleanexStreamStub, fn conn -> chunked(conn, [~s({"a":1}\n)]) end)

      assert {:ok, stream} = Streaming.chat(config, %{messages: []})

      task =
        Task.async(fn ->
          try do
            {:ok, Enum.to_list(stream)}
          rescue
            error in Error -> {:raised, error}
          end
        end)

      assert {:raised, %Error{reason: :usage, message: message}} = Task.await(task)
      assert message =~ "has to be consumed there"
    end

    test "consuming in the owning process is unaffected", %{config: config} do
      Req.Test.stub(GleanexStreamStub, fn conn -> chunked(conn, [~s({"a":1}\n)]) end)

      assert {:ok, stream} = Streaming.chat(config, %{messages: []})
      assert Enum.to_list(stream) == [%{"a" => 1}]
    end
  end
end
