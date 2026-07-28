%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/", "dev/", "test/"],
        # Generated code is not hand-edited, so style findings in it are noise.
        # Its shape is decided by config/config.exs and the generator plugin.
        excluded: [
          ~r"lib/gleanex/client/",
          ~r"lib/gleanex/indexing/",
          ~r"lib/gleanex/platform/",
          ~r"lib/gleanex/admin/"
        ]
      },
      strict: true,
      checks: %{
        disabled: [
          # Glean's field names are camelCase and Gleanex keeps them that way, so
          # test data and helpers legitimately mention them.
          {Credo.Check.Readability.VariableNames, []}
        ]
      }
    }
  ]
}
