defmodule Gleanex.Client.PinDocument do
  @moduledoc """
  Provides struct and type for a PinDocument
  """

  @type t :: %__MODULE__{
          attribution: Gleanex.Client.Person.t() | nil,
          audienceFilters: [Gleanex.Client.FacetFilter.t()] | nil,
          createTime: DateTime.t() | nil,
          documentId: String.t() | nil,
          favoriteInfo: Gleanex.Client.FavoriteInfo.t() | nil,
          id: String.t() | nil,
          queries: [String.t()] | nil,
          updateTime: DateTime.t() | nil,
          updatedBy: Gleanex.Client.Person.t() | nil
        }

  defstruct [
    :attribution,
    :audienceFilters,
    :createTime,
    :documentId,
    :favoriteInfo,
    :id,
    :queries,
    :updateTime,
    :updatedBy
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      attribution: {Gleanex.Client.Person, :t},
      audienceFilters: [{Gleanex.Client.FacetFilter, :t}],
      createTime: {:string, "date-time"},
      documentId: :string,
      favoriteInfo: {Gleanex.Client.FavoriteInfo, :t},
      id: :string,
      queries: [:string],
      updateTime: {:string, "date-time"},
      updatedBy: {Gleanex.Client.Person, :t}
    ]
  end
end
