# Dialyzer cannot see through oapi_generator's `use OpenAPI.Processor` macro,
# which defdelegates the behaviour's optional callbacks, so it reports every one
# of them plus `Naming.normalize_identifier/1` as undefined. They all exist and
# run: `mix glean.gen` regenerates all four APIs with this plugin in place.
#
# Scoped to this one dev-only file so real warnings in lib/ still surface.
[
  ~r"dev/gleanex/generator/processor\.ex"
]
