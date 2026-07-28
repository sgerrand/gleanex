defmodule Gleanex.Indexing.PropertyDefinition do
  @moduledoc """
  Provides struct and type for a PropertyDefinition
  """

  @type t :: %__MODULE__{
          displayLabel: String.t() | nil,
          displayLabelPlural: String.t() | nil,
          group: String.t() | nil,
          hideUiFacet: boolean | nil,
          name: String.t() | nil,
          propertyType: String.t() | nil,
          skipIndexing: boolean | nil,
          uiFacetOrder: integer | nil,
          uiOptions: String.t() | nil
        }

  defstruct [
    :displayLabel,
    :displayLabelPlural,
    :group,
    :hideUiFacet,
    :name,
    :propertyType,
    :skipIndexing,
    :uiFacetOrder,
    :uiOptions
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      displayLabel: :string,
      displayLabelPlural: :string,
      group: :string,
      hideUiFacet: :boolean,
      name: :string,
      propertyType:
        {:enum, ["TEXT", "DATE", "INT", "USERID", "PICKLIST", "TEXTLIST", "MULTIPICKLIST"]},
      skipIndexing: :boolean,
      uiFacetOrder: :integer,
      uiOptions: {:enum, ["NONE", "SEARCH_RESULT", "DOC_HOVERCARD"]}
    ]
  end
end
