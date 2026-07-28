defmodule Gleanex.Client.ListEntitiesRequest do
  @moduledoc """
  Provides struct and type for a ListEntitiesRequest
  """

  @type t :: %__MODULE__{
          cursor: String.t() | nil,
          datasource: String.t() | nil,
          entityType: String.t() | nil,
          filter: [Gleanex.Client.FacetFilter.t()] | nil,
          includeFields: [String.t()] | nil,
          pageSize: integer | nil,
          query: String.t() | nil,
          requestType: String.t() | nil,
          sort: [Gleanex.Client.SortOptions.t()] | nil,
          source: String.t() | nil
        }

  defstruct [
    :cursor,
    :datasource,
    :entityType,
    :filter,
    :includeFields,
    :pageSize,
    :query,
    :requestType,
    :sort,
    :source
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      cursor: :string,
      datasource: :string,
      entityType: {:enum, ["PEOPLE", "TEAMS", "CUSTOM_ENTITIES"]},
      filter: [{Gleanex.Client.FacetFilter, :t}],
      includeFields: [
        enum: [
          "PEOPLE",
          "TEAMS",
          "PEOPLE_DISTANCE",
          "PERMISSIONS",
          "FACETS",
          "INVITE_INFO",
          "LAST_EXTENSION_USE",
          "MANAGEMENT_DETAILS",
          "UNPROCESSED_TEAMS"
        ]
      ],
      pageSize: :integer,
      query: :string,
      requestType: {:enum, ["STANDARD", "FULL_DIRECTORY"]},
      sort: [{Gleanex.Client.SortOptions, :t}],
      source: :string
    ]
  end
end
