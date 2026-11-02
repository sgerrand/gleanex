defmodule Gleanex.Platform.SearchRequest do
  @moduledoc """
  Provides struct and type for a SearchRequest
  """

  @type t :: %__MODULE__{
          cursor: String.t() | nil,
          datasources: [String.t()] | nil,
          filters: [Gleanex.Platform.Filter.t()] | nil,
          page_size: integer | nil,
          query: String.t(),
          time_range: Gleanex.Platform.TimeRange.t() | nil
        }

  defstruct [:cursor, :datasources, :filters, :page_size, :query, :time_range]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      cursor: {:union, [:string, :null]},
      datasources: [:string],
      filters: [{Gleanex.Platform.Filter, :t}],
      page_size: :integer,
      query: :string,
      time_range: {Gleanex.Platform.TimeRange, :t}
    ]
  end
end
