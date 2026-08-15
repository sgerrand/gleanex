import Config

# How hard the property tests try. A hundred generations is enough to keep a
# pre-commit run honest without slowing it down; CI has the time to look
# properly, and a chunk boundary that only breaks once in a thousand splits is
# exactly what these tests are for.
if config_env() == :test do
  config :stream_data, max_runs: if(System.get_env("CI"), do: 1_000, else: 100)
end

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
end
