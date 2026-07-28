defmodule Gleanex.Client.ListShortcutsPaginatedRequest do
  @moduledoc """
  Provides struct and type for a ListShortcutsPaginatedRequest
  """

  @type t :: %__MODULE__{
          cursor: String.t() | nil,
          filters: [Gleanex.Client.FacetFilter.t()] | nil,
          includeFields: [String.t()] | nil,
          pageSize: integer,
          query: String.t() | nil,
          sort: Gleanex.Client.SortOptions.t() | nil
        }

  defstruct [:cursor, :filters, :includeFields, :pageSize, :query, :sort]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      cursor: :string,
      filters: [{Gleanex.Client.FacetFilter, :t}],
      includeFields: [enum: ["FACETS", "PEOPLE_DETAILS"]],
      pageSize: :integer,
      query: :string,
      sort: {Gleanex.Client.SortOptions, :t}
    ]
  end
end
