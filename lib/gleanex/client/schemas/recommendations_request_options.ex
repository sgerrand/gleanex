defmodule Gleanex.Client.RecommendationsRequestOptions do
  @moduledoc """
  Provides struct and type for a RecommendationsRequestOptions
  """

  @type t :: %__MODULE__{
          context: Gleanex.Client.Document.t() | nil,
          datasourceFilter: String.t() | nil,
          datasourcesFilter: [String.t()] | nil,
          facetFilterSets: [Gleanex.Client.FacetFilterSet.t()] | nil,
          resultProminence: [String.t()] | nil
        }

  defstruct [:context, :datasourceFilter, :datasourcesFilter, :facetFilterSets, :resultProminence]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      context: {Gleanex.Client.Document, :t},
      datasourceFilter: :string,
      datasourcesFilter: [:string],
      facetFilterSets: [{Gleanex.Client.FacetFilterSet, :t}],
      resultProminence: [enum: ["HERO", "PROMOTED", "STANDARD"]]
    ]
  end
end
