defmodule Mix.Tasks.Glean.Gen do
  @shortdoc "Regenerate the client from the vendored OpenAPI descriptions"

  @moduledoc """
  Run code generation for all four Glean APIs.

      mix glean.gen
      mix glean.gen platform

  This is a thin wrapper around `mix api.gen`, which has to be run once per
  profile. Each profile writes to its own directory under `lib/gleanex/`, and
  those directories are cleared first so that operations Glean has removed do
  not linger as stale files.

  Descriptions come from `priv/openapi/`; run `mix glean.specs` first to update
  them. Regeneration is deterministic, so a run with unchanged descriptions
  should leave the working tree clean.

  ## Arguments

  Zero or more profile names (`client`, `indexing`, `platform`, `admin`).
  Defaults to all four.
  """

  use Mix.Task

  @profiles %{
    "client" => "client_rest.yaml",
    "indexing" => "indexing.yaml",
    "platform" => "platform.yaml",
    "admin" => "admin_rest.yaml"
  }

  @impl Mix.Task
  def run(argv) do
    profiles = profiles(argv)

    Enum.each(profiles, fn profile ->
      spec = Path.join("priv/openapi", Map.fetch!(@profiles, profile))

      unless File.exists?(spec) do
        Mix.raise("#{spec} is missing. Run `mix glean.specs` first.")
      end

      location = Path.join("lib/gleanex", profile)
      File.rm_rf!(location)

      Mix.shell().info("Generating #{profile} from #{spec}")
      Mix.Task.rerun("api.gen", [profile, spec])
    end)

    Mix.shell().info("""

    Done. Check the result compiles and still matches the descriptions:

        mix compile --warnings-as-errors
        mix test
    """)
  end

  defp profiles([]), do: Map.keys(@profiles) |> Enum.sort()

  defp profiles(argv) do
    case Enum.reject(argv, &Map.has_key?(@profiles, &1)) do
      [] -> argv
      unknown -> Mix.raise("unknown profile(s): #{Enum.join(unknown, ", ")}")
    end
  end
end
