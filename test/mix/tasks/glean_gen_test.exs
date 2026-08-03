defmodule Mix.Tasks.Glean.GenTest do
  @moduledoc """
  The task clears and rewrites directories under the current working directory,
  so every test runs inside a temporary one. `Mix.Tasks.Api.Gen` is stubbed by
  `test/support/api_gen_task.ex`.
  """

  # Not async: changes the working directory and the Mix shell, both global.
  use ExUnit.Case, async: false

  alias Mix.Tasks.Glean.Gen

  @profiles ~w(admin client indexing platform)

  setup %{tmp_dir: tmp_dir} do
    previous_shell = Mix.shell()
    Mix.shell(Mix.Shell.Process)
    original = File.cwd!()

    File.cd!(tmp_dir)
    Process.delete(:api_gen_calls)

    on_exit(fn ->
      File.cd!(original)
      Mix.shell(previous_shell)
    end)

    :ok
  end

  defp write_specs(names \\ ~w(client_rest.yaml indexing.yaml platform.yaml admin_rest.yaml)) do
    File.mkdir_p!("priv/openapi")
    Enum.each(names, &File.write!(Path.join("priv/openapi", &1), "openapi: 3.0.0\n"))
  end

  defp calls, do: Process.get(:api_gen_calls, [])

  @tag :tmp_dir
  test "generates every profile when given no arguments" do
    write_specs()

    Gen.run([])

    assert calls() == [
             ["admin", "priv/openapi/admin_rest.yaml"],
             ["client", "priv/openapi/client_rest.yaml"],
             ["indexing", "priv/openapi/indexing.yaml"],
             ["platform", "priv/openapi/platform.yaml"]
           ]
  end

  @tag :tmp_dir
  test "generates only the profiles named" do
    write_specs()

    Gen.run(["platform", "indexing"])

    assert calls() == [
             ["platform", "priv/openapi/platform.yaml"],
             ["indexing", "priv/openapi/indexing.yaml"]
           ]
  end

  @tag :tmp_dir
  test "clears a profile's directory first, so removed operations do not linger" do
    write_specs()
    File.mkdir_p!("lib/gleanex/platform/operations")
    File.write!("lib/gleanex/platform/operations/gone.ex", "# an operation Glean removed\n")

    Gen.run(["platform"])

    refute File.exists?("lib/gleanex/platform/operations/gone.ex")
    assert File.exists?("lib/gleanex/platform/generated.ex")
  end

  @tag :tmp_dir
  test "leaves the other profiles' directories alone" do
    write_specs()
    File.mkdir_p!("lib/gleanex/client")
    File.write!("lib/gleanex/client/untouched.ex", "# still here\n")

    Gen.run(["platform"])

    assert File.exists?("lib/gleanex/client/untouched.ex")
  end

  @tag :tmp_dir
  test "explains how to fix a missing description rather than generating nothing" do
    write_specs(["client_rest.yaml"])

    assert_raise Mix.Error, ~r/priv\/openapi\/platform\.yaml is missing.*mix glean\.specs/s, fn ->
      Gen.run(["platform"])
    end

    assert calls() == []
  end

  @tag :tmp_dir
  test "rejects an unknown profile before touching anything" do
    write_specs()

    assert_raise Mix.Error, ~r/unknown profile\(s\): nope/, fn ->
      Gen.run(["nope"])
    end

    assert calls() == []
  end

  @tag :tmp_dir
  test "lists every unknown profile at once" do
    write_specs()

    assert_raise Mix.Error, ~r/unknown profile\(s\): nope, alsonope/, fn ->
      Gen.run(["nope", "client", "alsonope"])
    end
  end

  @tag :tmp_dir
  test "says what it did and what to run next" do
    write_specs()

    Gen.run(["client"])

    assert_received {:mix_shell, :info, ["Generating client from priv/openapi/client_rest.yaml"]}
    assert_received {:mix_shell, :info, [next_steps]}
    assert next_steps =~ "mix compile --warnings-as-errors"
    assert next_steps =~ "mix test"
  end

  @tag :tmp_dir
  test "knows the same four profiles the generator config defines" do
    write_specs()

    Gen.run([])

    assert calls() |> Enum.map(&List.first/1) |> Enum.sort() == @profiles
  end
end
