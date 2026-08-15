# Used by "mix format"
[
  # `check all` and `gen all` in the property tests read as function calls
  # without it, and the formatter wraps them in parentheses.
  import_deps: [:stream_data],
  inputs: ["{mix,.formatter}.exs", "{config,dev,lib,test}/**/*.{ex,exs}"]
]
