defmodule Gleanex.Client.InsightsOverviewResponse do
  @moduledoc """
  Provides struct and type for a InsightsOverviewResponse
  """

  @type t :: %__MODULE__{
          agentRunsTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          agentsDailyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          agentsMonthlyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          agentsWeeklyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          assistantDailyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          assistantInteractionsTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          assistantMonthlyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          assistantWeeklyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          chatDatasourceCounts: map | nil,
          dailyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          lastUpdatedTs: integer | nil,
          mcpCallsTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          mcpDailyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          mcpMonthlyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          mcpWeeklyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          monthlyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          perUserInsights: [Gleanex.Client.PerUserInsight.t()] | nil,
          searchDailyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          searchDatasourceCounts: map | nil,
          searchMonthlyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          searchSessionSatisfaction: number | nil,
          searchWeeklyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          searchesTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          weeklyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil
        }

  defstruct [
    :agentRunsTimeseries,
    :agentsDailyActiveUserTimeseries,
    :agentsMonthlyActiveUserTimeseries,
    :agentsWeeklyActiveUserTimeseries,
    :assistantDailyActiveUserTimeseries,
    :assistantInteractionsTimeseries,
    :assistantMonthlyActiveUserTimeseries,
    :assistantWeeklyActiveUserTimeseries,
    :chatDatasourceCounts,
    :dailyActiveUserTimeseries,
    :lastUpdatedTs,
    :mcpCallsTimeseries,
    :mcpDailyActiveUserTimeseries,
    :mcpMonthlyActiveUserTimeseries,
    :mcpWeeklyActiveUserTimeseries,
    :monthlyActiveUserTimeseries,
    :perUserInsights,
    :searchDailyActiveUserTimeseries,
    :searchDatasourceCounts,
    :searchMonthlyActiveUserTimeseries,
    :searchSessionSatisfaction,
    :searchWeeklyActiveUserTimeseries,
    :searchesTimeseries,
    :weeklyActiveUserTimeseries
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agentRunsTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      agentsDailyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      agentsMonthlyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      agentsWeeklyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      assistantDailyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      assistantInteractionsTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      assistantMonthlyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      assistantWeeklyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      chatDatasourceCounts: :map,
      dailyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      lastUpdatedTs: :integer,
      mcpCallsTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      mcpDailyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      mcpMonthlyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      mcpWeeklyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      monthlyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      perUserInsights: [{Gleanex.Client.PerUserInsight, :t}],
      searchDailyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      searchDatasourceCounts: :map,
      searchMonthlyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      searchSessionSatisfaction: {:number, "float"},
      searchWeeklyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      searchesTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      weeklyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t}
    ]
  end
end
