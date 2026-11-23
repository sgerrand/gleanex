defmodule Gleanex.Platform.SearchUsageResponse do
  @moduledoc """
  Provides struct and type for a SearchUsageResponse
  """

  @type t :: %__MODULE__{
          data_updated_at: DateTime.t() | nil,
          earliest_available_at: DateTime.t() | nil,
          has_more: boolean,
          labels: Gleanex.Platform.UsageSearchLabels.t() | nil,
          next_cursor: String.t() | nil,
          request_id: String.t(),
          results: [Gleanex.Platform.UsageSearchBucket.t()],
          target: Gleanex.Platform.UsageTarget.t(),
          time_range: Gleanex.Platform.UsageSearchTimeRange.t(),
          total_count: integer | nil,
          totals: [Gleanex.Platform.UsageUsedValue.t()]
        }

  defstruct [
    :data_updated_at,
    :earliest_available_at,
    :has_more,
    :labels,
    :next_cursor,
    :request_id,
    :results,
    :target,
    :time_range,
    :total_count,
    :totals
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      data_updated_at: {:union, [{:string, "date-time"}, :null]},
      earliest_available_at: {:union, [{:string, "date-time"}, :null]},
      has_more: :boolean,
      labels: {Gleanex.Platform.UsageSearchLabels, :t},
      next_cursor: {:union, [:string, :null]},
      request_id: :string,
      results: [{Gleanex.Platform.UsageSearchBucket, :t}],
      target: {Gleanex.Platform.UsageTarget, :t},
      time_range: {Gleanex.Platform.UsageSearchTimeRange, :t},
      total_count: :integer,
      totals: [{Gleanex.Platform.UsageUsedValue, :t}]
    ]
  end
end
