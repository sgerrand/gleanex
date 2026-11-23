defmodule Gleanex.Platform.SearchCallerUsageRequest do
  @moduledoc """
  Provides struct and type for a SearchCallerUsageRequest
  """

  @type t :: %__MODULE__{
          cursor: String.t() | nil,
          filters: [Gleanex.Platform.UsageSearchFilter.t()] | nil,
          granularity: String.t() | nil,
          group_by: [String.t()] | nil,
          include: [String.t()] | nil,
          metrics: [String.t()] | nil,
          page_size: integer | nil,
          sort: Gleanex.Platform.UsageSearchSort.t() | nil,
          time_range: Gleanex.Platform.UsageSearchTimeRange.t()
        }

  defstruct [
    :cursor,
    :filters,
    :granularity,
    :group_by,
    :include,
    :metrics,
    :page_size,
    :sort,
    :time_range
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      cursor: :string,
      filters: [{Gleanex.Platform.UsageSearchFilter, :t}],
      granularity: {:enum, ["NONE", "DAY", "WEEK", "MONTH"]},
      group_by: [
        enum: [
          "PRODUCT",
          "FEATURE",
          "MODEL_ID",
          "CLIENT_ID",
          "AGENT_ID",
          "USER_ID",
          "DEPARTMENT_NAME",
          "GROUP_ID"
        ]
      ],
      include: [enum: ["DISPLAY_NAMES", "TOTAL_COUNT"]],
      metrics: [enum: ["USED", "EVENT_COUNT"]],
      page_size: :integer,
      sort: {Gleanex.Platform.UsageSearchSort, :t},
      time_range: {Gleanex.Platform.UsageSearchTimeRange, :t}
    ]
  end
end
