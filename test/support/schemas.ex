defmodule Gleanex.Support.Schemas do
  @moduledoc """
  Stand-ins for generated schema modules.

  These mimic exactly what `oapi_generator` emits: a struct plus `__fields__/1`
  describing each field's type. Field names are Glean's own camelCase, because
  the generator carries spec field names through verbatim.

  Having them in `test/support` lets the decoder and transport be tested before
  any code is generated, and keeps those tests from breaking every time the
  specs are regenerated.
  """

  defmodule Person do
    @moduledoc false
    defstruct [:name, :email]

    @doc false
    @spec __fields__(atom) :: keyword
    def __fields__(type \\ :t)
    def __fields__(:t), do: [email: {:string, :generic}, name: {:string, :generic}]
  end

  defmodule Result do
    @moduledoc false
    defstruct [:title, :url, :author]

    @doc false
    @spec __fields__(atom) :: keyword
    def __fields__(type \\ :t)

    def __fields__(:t) do
      [author: {Person, :t}, title: {:string, :generic}, url: {:string, :generic}]
    end
  end

  defmodule SearchResponse do
    @moduledoc false
    defstruct [:trackingToken, :hasMoreResults, :cursor, results: []]

    @doc false
    @spec __fields__(atom) :: keyword
    def __fields__(type \\ :t)

    def __fields__(:t) do
      [
        cursor: {:string, :generic},
        hasMoreResults: :boolean,
        results: [{Result, :t}],
        trackingToken: {:string, :generic}
      ]
    end
  end
end
