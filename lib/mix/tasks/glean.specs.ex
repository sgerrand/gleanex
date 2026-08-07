defmodule Mix.Tasks.Glean.Specs do
  @shortdoc "Download Glean's OpenAPI descriptions into priv/openapi"

  @moduledoc """
  Vendor Glean's OpenAPI descriptions so the generated code can be reproduced.

      mix glean.specs
      mix glean.specs --ref 9b36aa40d235af4dfc387e9f4c62ed95a8dae326

  Files are taken from `source_specs/` in
  [gleanwork/open-api](https://github.com/gleanwork/open-api). That directory is
  the right one: `final_specs/` carries the same APIs with code samples merged
  in, which inflates the Client API description from under 400 KB to about
  19 MB without adding anything a generator can use.

  A floating ref such as `main` is resolved to a commit SHA first, and every
  file is then fetched at that SHA, so a run can never mix files from two
  different commits. The SHA and each description's own version are written to
  `priv/openapi/.api-version`.

  ## Options

    * `--ref` - branch, tag or commit to download. Defaults to `main`.
    * `--force` - overwrite local edits without asking.

  ## Authentication

  Resolving the ref goes through GitHub's API, which allows 60 calls an hour
  per IP address without a token. Hosted CI runners share addresses, so that
  allowance is usually already spent and GitHub answers 403. Set `GITHUB_TOKEN`
  (or `GH_TOKEN`) and the call is authenticated instead, which raises the limit
  to 1,000 an hour. Any token with read access works; the repository is public.
  """

  use Mix.Task

  @repo "gleanwork/open-api"
  @directory "source_specs"
  @specs ~w(client_rest.yaml indexing.yaml platform.yaml admin_rest.yaml)
  @output "priv/openapi"

  @impl Mix.Task
  def run(argv) do
    {opts, _argv} = OptionParser.parse!(argv, strict: [ref: :string, force: :boolean])
    Mix.Task.run("app.start")

    ref = Keyword.get(opts, :ref, "main")
    sha = resolve_ref(ref)

    Mix.shell().info("Fetching Glean OpenAPI descriptions from #{@repo} at #{sha}")
    File.mkdir_p!(@output)

    versions =
      Enum.map(@specs, fn spec ->
        body = download(spec, sha)
        path = Path.join(@output, spec)

        if write?(path, body, opts) do
          File.write!(path, body)
          Mix.shell().info("  * #{path} (#{format_size(byte_size(body))})")
        else
          Mix.shell().info("  * #{path} unchanged")
        end

        {spec, spec_version(body)}
      end)

    write_version_file(sha, ref, versions)

    Mix.shell().info("""

    Wrote #{@output}/.api-version. Regenerate the client with:

        mix glean.gen
    """)
  end

  defp resolve_ref(ref) do
    case Req.get("https://api.github.com/repos/#{@repo}/commits/#{ref}",
           headers: [{"accept", "application/vnd.github.sha"} | auth_header()]
         ) do
      {:ok, %{status: 200, body: sha}} when is_binary(sha) ->
        String.trim(sha)

      {:ok, %{status: status} = response} ->
        Mix.raise(
          "could not resolve ref #{inspect(ref)} in #{@repo} " <>
            "(HTTP #{status})#{rate_limit_note(response)}"
        )

      {:error, exception} ->
        Mix.raise("could not reach GitHub: #{Exception.message(exception)}")
    end
  end

  defp auth_header do
    case System.get_env("GITHUB_TOKEN") || System.get_env("GH_TOKEN") do
      token when is_binary(token) and token != "" -> [{"authorization", "Bearer #{token}"}]
      _ -> []
    end
  end

  # A spent rate limit is the usual reason for a 403 here, and GitHub says so
  # only in a header, so the message would otherwise send someone looking for a
  # ref that exists.
  defp rate_limit_note(response) do
    case Req.Response.get_header(response, "x-ratelimit-remaining") do
      ["0" | _] ->
        ". GitHub's rate limit for this address is spent; set GITHUB_TOKEN to raise it"

      _ ->
        ""
    end
  end

  defp download(spec, sha) do
    url = "https://raw.githubusercontent.com/#{@repo}/#{sha}/#{@directory}/#{spec}"

    case Req.get(url, decode_body: false) do
      {:ok, %{status: 200, body: body}} ->
        body

      {:ok, %{status: status}} ->
        Mix.raise("could not download #{spec} (HTTP #{status})")

      {:error, exception} ->
        Mix.raise("could not download #{spec}: #{Exception.message(exception)}")
    end
  end

  defp write?(path, body, opts) do
    cond do
      not File.exists?(path) -> true
      File.read!(path) == body -> false
      Keyword.get(opts, :force, false) -> true
      true -> Mix.shell().yes?("#{path} differs from the downloaded copy. Overwrite?")
    end
  end

  # Read `info.version` without a YAML parser: it is always a top level scalar
  # a couple of lines into the file, and this task should not need a parser just
  # to write a provenance note.
  defp spec_version(body) do
    case Regex.run(~r/^[ \t]{2}version:[ \t]*["']?([^"'\s]+)/m, body) do
      [_, version] -> version
      nil -> "unknown"
    end
  end

  defp write_version_file(sha, ref, versions) do
    contents = """
    # Provenance of the OpenAPI descriptions in this directory.
    # Written by `mix glean.specs`; do not edit by hand.
    repository: #{@repo}
    directory: #{@directory}
    ref: #{ref}
    commit: #{sha}
    #{Enum.map_join(versions, "\n", fn {spec, version} -> "#{spec}: #{version}" end)}
    """

    File.write!(Path.join(@output, ".api-version"), contents)
  end

  defp format_size(bytes) when bytes < 1024, do: "#{bytes} B"
  defp format_size(bytes) when bytes < 1024 * 1024, do: "#{div(bytes, 1024)} KB"
  defp format_size(bytes), do: "#{Float.round(bytes / (1024 * 1024), 1)} MB"
end
