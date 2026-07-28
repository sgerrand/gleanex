defmodule Gleanex.Client.ListEntitiesResponse do
  @moduledoc """
  Provides struct and type for a ListEntitiesResponse
  """

  @type t :: %__MODULE__{
          cursor: String.t() | nil,
          customEntityResults: [Gleanex.Client.CustomEntity.t()] | nil,
          customFacetNames: [String.t()] | nil,
          facetResults: [Gleanex.Client.FacetResult.t()] | nil,
          hasMoreResults: boolean | nil,
          results: [Gleanex.Client.Person.t()] | nil,
          sortOptions: [String.t()] | nil,
          teamResults: [Gleanex.Client.Team.t()] | nil,
          totalCount: integer | nil
        }

  defstruct [
    :cursor,
    :customEntityResults,
    :customFacetNames,
    :facetResults,
    :hasMoreResults,
    :results,
    :sortOptions,
    :teamResults,
    :totalCount
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      cursor: :string,
      customEntityResults: [{Gleanex.Client.CustomEntity, :t}],
      customFacetNames: [:string],
      facetResults: [{Gleanex.Client.FacetResult, :t}],
      hasMoreResults: :boolean,
      results: [{Gleanex.Client.Person, :t}],
      sortOptions: [
        enum: [
          "ENTITY_NAME",
          "FIRST_NAME",
          "LAST_NAME",
          "ORG_SIZE_COUNT",
          "START_DATE",
          "TEAM_SIZE",
          "RELEVANCE"
        ]
      ],
      teamResults: [{Gleanex.Client.Team, :t}],
      totalCount: :integer
    ]
  end
end
