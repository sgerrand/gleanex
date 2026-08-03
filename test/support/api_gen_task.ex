defmodule Mix.Tasks.Api.Gen do
  @moduledoc """
  Stand-in for oapi_generator's `mix api.gen`.

  `mix glean.gen` shells out to `api.gen` once per profile. The real task comes
  from oapi_generator, which is a `:dev` dependency and so is absent here, which
  leaves the name free for this to occupy in the test environment only.

  It records its arguments in the process dictionary of whoever started it, so a
  test can assert which profiles were generated and in what order, and writes a
  marker file so the surrounding file handling can be checked too.
  """

  use Mix.Task

  @impl Mix.Task
  def run(args) do
    Process.put(:api_gen_calls, Process.get(:api_gen_calls, []) ++ [args])

    case args do
      [profile, _spec] ->
        location = Path.join("lib/gleanex", profile)
        File.mkdir_p!(location)
        File.write!(Path.join(location, "generated.ex"), "# generated for #{profile}\n")

      _ ->
        :ok
    end

    :ok
  end
end
