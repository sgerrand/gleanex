defmodule Gleanex.GeneratedTest do
  @moduledoc """
  Checks the committed generated code against the vendored descriptions.

  The generated tree is committed, so it can drift: a spec is updated but
  `mix glean.gen` is not re-run, or a regeneration is only half committed. These
  tests fail loudly when that happens, which is the whole reason for committing
  generated code rather than generating at build time.
  """

  use ExUnit.Case, async: true

  @profiles [
    {:client, "client_rest.yaml", "lib/gleanex/client"},
    {:indexing, "indexing.yaml", "lib/gleanex/indexing"},
    {:platform, "platform.yaml", "lib/gleanex/platform"},
    {:admin, "admin_rest.yaml", "lib/gleanex/admin"}
  ]

  @methods ~w(get put post delete patch head options trace)

  describe "coverage" do
    for {profile, spec_file, location} <- @profiles do
      test "every #{profile} operation in the description has generated code" do
        described = described_operations(unquote(spec_file))
        generated = generated_operations(unquote(location))

        assert described != [], "no operations found in #{unquote(spec_file)}"

        missing = described -- generated

        assert missing == [],
               """
               #{length(missing)} operation(s) in #{unquote(spec_file)} have no generated code.
               Run `mix glean.gen` and commit the result.

               #{Enum.map_join(Enum.take(missing, 20), "\n", fn {method, path} -> "  #{method} #{path}" end)}
               """
      end

      test "no #{profile} operation is generated that the description does not describe" do
        described = described_operations(unquote(spec_file))
        generated = generated_operations(unquote(location))

        extra = generated -- described

        assert extra == [],
               """
               #{length(extra)} generated operation(s) are not in #{unquote(spec_file)}.
               The generated tree is stale; run `mix glean.gen` and commit the result.

               #{Enum.map_join(Enum.take(extra, 20), "\n", fn {method, path} -> "  #{method} #{path}" end)}
               """
      end
    end
  end

  describe "wiring" do
    test "every operation module routes through Gleanex.HTTP" do
      for {_profile, _spec, location} <- @profiles,
          path <- Path.wildcard(Path.join(location, "operations/*.ex")) do
        source = File.read!(path)

        assert source =~ "@default_client Gleanex.HTTP",
               "#{path} does not default to Gleanex.HTTP"
      end
    end

    test "operations report themselves in :call, which is how the API namespace is resolved" do
      for {_profile, _spec, location} <- @profiles,
          path <- Path.wildcard(Path.join(location, "operations/*.ex")) do
        source = File.read!(path)
        [module] = Regex.run(~r/^defmodule ([\w.]+) do/m, source, capture: :all_but_first)

        for [called] <- Regex.scan(~r/call: \{([\w.]+), :\w+\}/, source, capture: :all_but_first) do
          assert called == module, "#{path} reports :call as #{called}"
        end
      end
    end

    test "every API namespace resolves to the right base URL prefix" do
      config = Gleanex.new(domain: "acme", token: "t")

      assert Gleanex.HTTP.api_for(Gleanex.Client.Search) == :client
      assert Gleanex.HTTP.api_for(Gleanex.Indexing.Documents) == :indexing
      assert Gleanex.HTTP.api_for(Gleanex.Platform.Agents) == :platform
      assert Gleanex.HTTP.api_for(Gleanex.Admin.Governance) == :admin

      assert Gleanex.Config.base_url(config, Gleanex.HTTP.api_for(Gleanex.Platform.Skills)) ==
               "https://acme-be.glean.com/api"
    end
  end

  describe "provenance" do
    test "the vendored descriptions record where they came from" do
      version = File.read!("priv/openapi/.api-version")

      assert version =~ "repository: gleanwork/open-api"
      assert version =~ "directory: source_specs"
      assert version =~ ~r/commit: [0-9a-f]{40}/

      for {_profile, spec_file, _location} <- @profiles do
        assert version =~ spec_file
        assert File.exists?(Path.join("priv/openapi", spec_file))
      end
    end
  end

  # Path and method pairs the description declares.
  defp described_operations(spec_file) do
    "priv/openapi"
    |> Path.join(spec_file)
    |> YamlElixir.read_from_file!()
    |> Map.get("paths", %{})
    |> Enum.flat_map(fn {path, item} ->
      item
      |> Map.keys()
      |> Enum.filter(&(&1 in @methods))
      |> Enum.map(&{&1, normalise(path)})
    end)
    |> Enum.sort()
  end

  # Path and method pairs the committed code actually calls. Read from source
  # rather than at runtime because the operation map is built inside each
  # function body.
  defp generated_operations(location) do
    location
    |> Path.join("operations/*.ex")
    |> Path.wildcard()
    |> Enum.flat_map(fn file ->
      source = File.read!(file)

      ~r/url: "([^"]+)",\n\s*(?:body: [^\n]+,\n\s*)?method: :(\w+)/
      |> Regex.scan(source, capture: :all_but_first)
      |> Enum.map(fn [url, method] -> {method, normalise(url)} end)
    end)
    |> Enum.uniq()
    |> Enum.sort()
  end

  # `/agents/{agent_id}/runs` and `/agents/\#{agent_id}/runs` describe the same
  # endpoint, and the description's parameter names are camelCase while the
  # generated ones are snake_case, so both collapse to a placeholder.
  defp normalise(path) do
    path
    |> String.replace(~r/\#\{[^}]+\}/, ":param")
    |> String.replace(~r/\{[^}]+\}/, ":param")
  end
end
