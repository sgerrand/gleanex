import Config

# Code generation settings for `mix glean.gen`. Nothing here affects Gleanex at
# runtime; users configure the library under the `:gleanex` key instead.
#
# Scoped to :dev because oapi_generator is a dev-only dependency, and Mix warns
# about configuring an application that is not available.
#
# One profile per Glean API. Separate profiles matter: all four descriptions
# define schemas with the same names (Person, Document, Datasource), so a shared
# base module would have them overwrite each other.
#
# Field names are left exactly as the descriptions declare them, which means
# Glean's own camelCase. `output.field_casing: :snake` would read better in
# Elixir, but request bodies are plain maps that must stay camelCase for Glean
# to accept them, and having responses disagree with requests is worse than
# having both match Glean's documentation.
shared = [
  # Deprecated operations are kept. Glean still serves them and the Go SDK still
  # exposes them, so dropping them would lose working endpoints.
  #
  # Note the generator emits nothing for a `deprecated: true` flag, so these
  # functions carry no marker unless Glean spelled it out in the description
  # text. Worth revisiting with a renderer plugin if it starts to bite.
  ignore: [],
  # See the moduledoc: fixes operation function names that would otherwise
  # repeat their module, or fall back to path-plus-method.
  processor: Gleanex.Generator.Processor,
  output: [
    default_client: Gleanex.HTTP,
    operation_subdirectory: "operations/",
    schema_subdirectory: "schemas/",
    types: [
      # Gleanex normalises every failure into one struct, so the generated
      # specs should say so rather than listing per-operation error schemas.
      error: {Gleanex.Error, :t}
    ]
  ]
]

put_output = fn config, extra ->
  Keyword.put(config, :output, Keyword.merge(config[:output], extra))
end

if config_env() == :dev do
  config :oapi_generator,
    client: put_output.(shared, base_module: Gleanex.Client, location: "lib/gleanex/client"),
    indexing:
      put_output.(shared, base_module: Gleanex.Indexing, location: "lib/gleanex/indexing"),
    platform:
      put_output.(shared, base_module: Gleanex.Platform, location: "lib/gleanex/platform"),
    admin: put_output.(shared, base_module: Gleanex.Admin, location: "lib/gleanex/admin")

  # Local git hooks, run by git_hooks. These mirror the CI jobs in
  # .github/workflows/ci.yml, split by how long they take: the cheap checks run
  # on every commit, the slow ones only when work leaves the machine.
  #
  # Dialyzer is left out of both. Its first run builds a PLT that takes minutes,
  # which is too much to put in front of a push; CI runs it on its own cached
  # PLT instead.
  #
  # Skip either with `git commit --no-verify` / `git push --no-verify`.
  config :git_hooks,
    # Writes .git/hooks/pre-commit and .git/hooks/pre-push on the first compile
    # after `mix deps.get`, so a fresh clone needs no extra setup step.
    auto_install: true,
    verbose: true,
    hooks: [
      pre_commit: [
        tasks: [
          # Both are seconds on an already-compiled tree, and both fail for
          # reasons the author can fix on the spot.
          {:cmd, "mix format --check-formatted"},
          {:cmd, "mix credo --strict"}
        ]
      ],
      pre_push: [
        tasks: [
          {:cmd, "mix compile --warnings-as-errors"},
          # --cover, not plain `mix test`: the 100% threshold in mix.exs is only
          # enforced with it, and that is the check worth having here.
          {:cmd, "mix test --cover"}
        ]
      ]
    ]
end
