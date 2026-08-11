defmodule Gleanex.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/sgerrand/gleanex"

  # Kept out of the published documentation. Dev-only build tooling, plus the
  # three modules that only exist to serve the transport: chunk reassembly
  # shared by Gleanex.SSE and Gleanex.NDJSON, and the encode and decode steps
  # either side of a request. None is part of the published surface, and the two
  # Mix tasks are not even in the package; the README documents those for
  # contributors instead.
  @undocumented [
    Gleanex.Generator.Processor,
    Mix.Tasks.Glean.Gen,
    Mix.Tasks.Glean.Specs,
    Gleanex.Framing,
    Gleanex.Body,
    Gleanex.Decoder
  ]

  def project do
    [
      app: :gleanex,
      version: @version,
      # 1.18 is the floor because the JSON module arrived there, and
      # Gleanex.Body, Gleanex.NDJSON, Gleanex.SSE and Gleanex.Streaming use it.
      # CI runs the test suite against every minor from here up.
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      description: "Elixir client for the Glean Client, Indexing, Platform and Admin APIs.",
      package: package(),
      docs: docs(),
      name: "Gleanex",
      source_url: @source_url,
      test_coverage: [
        # Nested under :summary deliberately. A top-level `threshold:` is
        # accepted without complaint and then ignored, leaving the default of 90
        # in force, so the setting has to live here to actually be enforced.
        summary: [threshold: 100],
        # Test scaffolding under test/support: stand-ins for generated schemas
        # and operations, plus a stub for oapi_generator's api.gen task, which
        # is absent in this environment. They exist to exercise the library, so
        # measuring them measures the tests rather than the code. No generated
        # module carries "Support" in its name, so nothing real is hidden here.
        ignore_modules: [~r/^Gleanex\..*Support/, Mix.Tasks.Api.Gen]
      ],
      dialyzer: [
        plt_add_apps: [:mix],
        ignore_warnings: ".dialyzer_ignore.exs",
        # Kept out of _build so CI can cache it on its own key: the PLT only
        # changes when the compiler or the dependencies do.
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # `dev/mix` holds the repository's own Mix tasks, which depend on nothing a
  # consumer does not already have. They live outside `lib` so that they cannot
  # reach the package: `mix glean.gen` drives oapi_generator, which is not a
  # dependency of the built package, so shipping the task would put a broken
  # entry in every consumer's `mix help`. Their tests need them compiled.
  defp elixirc_paths(:test), do: ["lib", "dev/mix", "test/support"]
  # The rest of `dev/` is the code generation plugin. It depends on
  # oapi_generator, a dev-only dependency, so it must never be compiled into the
  # package.
  defp elixirc_paths(:dev), do: ["lib", "dev"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:req, "~> 0.7"},
      {:telemetry, "~> 1.2"},
      # Req.Test builds its stubs on Plug.Conn.
      {:plug, "~> 1.16", only: :test},
      {:oapi_generator, "~> 0.4", only: :dev, runtime: false},
      {:yaml_elixir, "~> 2.9", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      # Runs the pre-commit and pre-push hooks configured in .git_hoox.exs.
      # Dev only: the hooks are a local convenience, and CI runs the same checks
      # itself.
      {:git_hoox, "~> 0.4", only: [:dev], runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["BSD-2-Clause"],
      links: %{
        "GitHub" => @source_url,
        "Glean OpenAPI specs" => "https://github.com/gleanwork/open-api"
      },
      # The descriptions themselves are not shipped: they are only needed to
      # regenerate, which happens in the repository. The provenance file is,
      # so an installed copy can say which upstream commit it came from.
      files:
        ~w(lib priv/openapi/.api-version .formatter.exs mix.exs README.md CHANGELOG.md LICENSE)
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md", "CHANGELOG.md"],
      source_ref: "v#{@version}",
      # ex_doc takes a predicate here, and has no `:ignore_modules` option. An
      # unrecognised key is accepted in silence rather than refused, so spelling
      # it the other way documents the lot and reports nothing.
      filter_modules: fn module, _metadata -> module not in @undocumented end,
      # Every module not matched here lands in an unnamed group below the five
      # hundred generated ones, so anything documented has to be listed.
      groups_for_modules: [
        Core: [
          Gleanex,
          Gleanex.Config,
          Gleanex.Error,
          Gleanex.HTTP,
          Gleanex.Retry,
          Gleanex.Pagination,
          Gleanex.Bulk,
          Gleanex.Streaming,
          Gleanex.SSE,
          Gleanex.SSE.Event,
          Gleanex.NDJSON,
          Gleanex.ProblemDetail
        ],
        "Client API": [~r/^Gleanex\.Client\./],
        "Indexing API": [~r/^Gleanex\.Indexing\./],
        "Platform API": [~r/^Gleanex\.Platform\./],
        "Admin API": [~r/^Gleanex\.Admin\./]
      ]
    ]
  end
end
