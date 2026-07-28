defmodule Gleanex.Client.McpInsightsResponse do
  @moduledoc """
  Provides struct and type for a McpInsightsResponse
  """

  @type t :: %__MODULE__{
          dailyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          dailyActiveUsers: integer | nil,
          monthlyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          monthlyActiveUsers: integer | nil,
          overallDailyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          topHostApplicationsActiveUserTimeseries: [Gleanex.Client.LabeledCountInfo.t()] | nil,
          weeklyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          weeklyActiveUsers: integer | nil
        }

  defstruct [
    :dailyActiveUserTimeseries,
    :dailyActiveUsers,
    :monthlyActiveUserTimeseries,
    :monthlyActiveUsers,
    :overallDailyActiveUserTimeseries,
    :topHostApplicationsActiveUserTimeseries,
    :weeklyActiveUserTimeseries,
    :weeklyActiveUsers
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      dailyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      dailyActiveUsers: :integer,
      monthlyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      monthlyActiveUsers: :integer,
      overallDailyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      topHostApplicationsActiveUserTimeseries: [{Gleanex.Client.LabeledCountInfo, :t}],
      weeklyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      weeklyActiveUsers: :integer
    ]
  end
end
