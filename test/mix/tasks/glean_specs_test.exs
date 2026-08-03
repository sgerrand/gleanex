defmodule Mix.Tasks.Glean.SpecsTest do
  @moduledoc """
  The task talks to GitHub through `Req` directly, so `Req.default_options/1`
  routes it at a stub instead. That is global, which is safe here because ExUnit
  runs synchronous modules on their own, after every async one has finished.
  """

  # Not async: changes the working directory, the Mix shell and Req's defaults.
  use ExUnit.Case, async: false

  alias Mix.Tasks.Glean.Specs

  @sha "0daf919ce853f700e69786c6e87a973920931759"
  @specs ~w(client_rest.yaml indexing.yaml platform.yaml admin_rest.yaml)

  setup %{tmp_dir: tmp_dir} = context do
    Req.Test.set_req_test_from_context(context)

    previous_shell = Mix.shell()
    previous_req = Req.default_options()
    original = File.cwd!()

    Mix.shell(Mix.Shell.Process)
    # retry: false because the failure tests would otherwise spend Req's default
    # backoff, several seconds each, re-reaching a stub that will not change its
    # mind. The task itself sets no retry policy, so this only affects timing.
    Req.default_options(plug: {Req.Test, GleanSpecsStub}, retry: false)
    File.cd!(tmp_dir)

    on_exit(fn ->
      File.cd!(original)
      Mix.shell(previous_shell)
      Req.default_options(previous_req)
    end)

    :ok
  end

  # Answers the ref lookup with a SHA and every download with a body built by
  # `spec_body`, so a test can vary size and contents.
  defp stub_github(opts \\ []) do
    sha = Keyword.get(opts, :sha, @sha)
    body = Keyword.get(opts, :body, fn _spec -> "openapi: 3.0.0\ninfo:\n  version: 0.9.0\n" end)

    Req.Test.stub(GleanSpecsStub, fn conn ->
      if conn.request_path =~ ~r{/repos/gleanwork/open-api/commits/} do
        conn
        |> Plug.Conn.put_resp_content_type("text/plain")
        |> Plug.Conn.send_resp(200, sha)
      else
        Plug.Conn.send_resp(conn, 200, body.(Path.basename(conn.request_path)))
      end
    end)
  end

  defp version_file, do: File.read!("priv/openapi/.api-version")

  describe "a first download" do
    @tag :tmp_dir
    test "writes every description and a provenance file" do
      stub_github()

      Specs.run([])

      for spec <- @specs do
        assert File.exists?(Path.join("priv/openapi", spec))
      end

      contents = version_file()
      assert contents =~ "repository: gleanwork/open-api"
      assert contents =~ "directory: source_specs"
      assert contents =~ "ref: main"
      assert contents =~ "commit: #{@sha}"

      for spec <- @specs, do: assert(contents =~ "#{spec}: 0.9.0")
    end

    @tag :tmp_dir
    test "resolves the ref to a commit first, so one run cannot mix two commits" do
      stub_github()

      Specs.run([])

      assert_received {:mix_shell, :info, [first_line]}

      assert first_line ==
               "Fetching Glean OpenAPI descriptions from gleanwork/open-api at #{@sha}"
    end

    @tag :tmp_dir
    test "downloads the given ref when one is passed" do
      stub_github()

      Specs.run(["--ref", "v1.2.3"])

      assert version_file() =~ "ref: v1.2.3"
    end

    @tag :tmp_dir
    test "records the version as unknown when a description does not declare one" do
      stub_github(body: fn _spec -> "openapi: 3.0.0\n" end)

      Specs.run([])

      for spec <- @specs, do: assert(version_file() =~ "#{spec}: unknown")
    end

    @tag :tmp_dir
    test "reports each file's size" do
      sizes = %{
        "client_rest.yaml" => 2_000_000,
        "indexing.yaml" => 5_000,
        "platform.yaml" => 100,
        "admin_rest.yaml" => 100
      }

      stub_github(body: fn spec -> String.duplicate("x", Map.fetch!(sizes, spec)) end)

      Specs.run([])

      reported = collect_info()

      assert Enum.any?(reported, &(&1 =~ ~r/client_rest\.yaml \(1\.9 MB\)/))
      assert Enum.any?(reported, &(&1 =~ ~r/indexing\.yaml \(4 KB\)/))
      assert Enum.any?(reported, &(&1 =~ ~r/platform\.yaml \(100 B\)/))
    end
  end

  describe "a repeat download" do
    @tag :tmp_dir
    test "leaves unchanged files alone" do
      stub_github()
      Specs.run([])
      flush()

      Specs.run([])

      reported = collect_info()
      for spec <- @specs, do: assert(Enum.any?(reported, &(&1 =~ "#{spec} unchanged")))
    end

    @tag :tmp_dir
    test "asks before overwriting a changed file" do
      stub_github()
      Specs.run([])
      flush()

      stub_github(body: fn _spec -> "openapi: 3.0.0\ninfo:\n  version: 1.0.0\n" end)
      for _spec <- @specs, do: send(self(), {:mix_shell_input, :yes?, true})

      Specs.run([])

      assert File.read!("priv/openapi/platform.yaml") =~ "version: 1.0.0"
      assert version_file() =~ "platform.yaml: 1.0.0"
    end

    @tag :tmp_dir
    test "keeps the local copy when the answer is no" do
      stub_github()
      Specs.run([])
      flush()

      stub_github(body: fn _spec -> "openapi: 3.0.0\ninfo:\n  version: 1.0.0\n" end)
      for _spec <- @specs, do: send(self(), {:mix_shell_input, :yes?, false})

      Specs.run([])

      assert File.read!("priv/openapi/platform.yaml") =~ "version: 0.9.0"
    end

    @tag :tmp_dir
    test "overwrites without asking when forced" do
      stub_github()
      Specs.run([])
      flush()

      stub_github(body: fn _spec -> "openapi: 3.0.0\ninfo:\n  version: 1.0.0\n" end)

      Specs.run(["--force"])

      assert File.read!("priv/openapi/platform.yaml") =~ "version: 1.0.0"
      refute_received {:mix_shell, :yes?, _}
    end
  end

  describe "failures" do
    @tag :tmp_dir
    test "explains an unresolvable ref" do
      Req.Test.stub(GleanSpecsStub, fn conn -> Plug.Conn.send_resp(conn, 404, "Not Found") end)

      assert_raise Mix.Error, ~r/could not resolve ref "nope".*HTTP 404/s, fn ->
        Specs.run(["--ref", "nope"])
      end
    end

    @tag :tmp_dir
    test "explains a ref lookup that never reached GitHub" do
      Req.Test.stub(GleanSpecsStub, fn conn ->
        Req.Test.transport_error(conn, :econnrefused)
      end)

      assert_raise Mix.Error, ~r/could not reach GitHub/, fn ->
        Specs.run([])
      end
    end

    @tag :tmp_dir
    test "explains a description that could not be downloaded" do
      Req.Test.stub(GleanSpecsStub, fn conn ->
        if conn.request_path =~ ~r{/commits/} do
          conn |> Plug.Conn.put_resp_content_type("text/plain") |> Plug.Conn.send_resp(200, @sha)
        else
          Plug.Conn.send_resp(conn, 500, "boom")
        end
      end)

      assert_raise Mix.Error, ~r/could not download client_rest\.yaml \(HTTP 500\)/, fn ->
        Specs.run([])
      end
    end

    @tag :tmp_dir
    test "explains a download that never reached GitHub" do
      Req.Test.stub(GleanSpecsStub, fn conn ->
        if conn.request_path =~ ~r{/commits/} do
          conn |> Plug.Conn.put_resp_content_type("text/plain") |> Plug.Conn.send_resp(200, @sha)
        else
          Req.Test.transport_error(conn, :closed)
        end
      end)

      assert_raise Mix.Error, ~r/could not download client_rest\.yaml:/, fn ->
        Specs.run([])
      end
    end

    @tag :tmp_dir
    test "rejects an unknown switch" do
      assert_raise OptionParser.ParseError, fn ->
        Specs.run(["--nonsense"])
      end
    end
  end

  defp collect_info(acc \\ []) do
    receive do
      {:mix_shell, :info, [message]} -> collect_info([message | acc])
    after
      0 -> Enum.reverse(acc)
    end
  end

  defp flush do
    receive do
      _ -> flush()
    after
      0 -> :ok
    end
  end
end
