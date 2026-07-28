defmodule Gleanex.Client.GetDocumentsByFacetsRequest do
  @moduledoc """
  Provides struct and type for a GetDocumentsByFacetsRequest
  """

  @type t :: %__MODULE__{
          cursor: String.t() | nil,
          datasourcesFilter: [String.t()] | nil,
          filterSets: [Gleanex.Client.FacetFilterSet.t()]
        }

  defstruct [:cursor, :datasourcesFilter, :filterSets]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      cursor: :string,
      datasourcesFilter: [:string],
      filterSets: [{Gleanex.Client.FacetFilterSet, :t}]
    ]
  end
end
