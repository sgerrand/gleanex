defmodule Gleanex.Platform.SearchEnumerationRequest do
  @moduledoc """
  Provides struct and type for a SearchEnumerationRequest
  """

  @type t :: %__MODULE__{
          cursor: String.t() | nil,
          datasources: [String.t()] | nil,
          filters: [Gleanex.Platform.Filter.t()] | nil,
          include: [String.t()] | nil,
          page_size: integer | nil,
          query: String.t() | nil,
          time_range: Gleanex.Platform.TimeRange.t() | nil
        }

  defstruct [:cursor, :datasources, :filters, :include, :page_size, :query, :time_range]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      cursor: {:union, [:string, :null]},
      datasources: [:string],
      filters: [{Gleanex.Platform.Filter, :t}],
      include: [const: "SNIPPETS"],
      page_size: :integer,
      query: :string,
      time_range: {Gleanex.Platform.TimeRange, :t}
    ]
  end
end
