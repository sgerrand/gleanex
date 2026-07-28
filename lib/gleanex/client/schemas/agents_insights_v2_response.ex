defmodule Gleanex.Client.AgentsInsightsV2Response do
  @moduledoc """
  Provides struct and type for a AgentsInsightsV2Response
  """

  @type t :: %__MODULE__{
          agentUsersInsights: [Gleanex.Client.AgentUsersInsight.t()] | nil,
          agentsTimeSavedInsights: [Gleanex.Client.AgentsTimeSavedInsight.t()] | nil,
          agentsUsageByDepartmentInsights:
            [Gleanex.Client.AgentsUsageByDepartmentInsight.t()] | nil,
          dailyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          dailyAgentRunsTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          downvotesTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          failedRunsTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          monthlyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          monthlyActiveUsers: integer | nil,
          pausedRunsTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          sharedAgentsCount: integer | nil,
          successfulRunsTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          topAgentsInsights: [Gleanex.Client.PerAgentInsight.t()] | nil,
          topUseCasesInsights: [Gleanex.Client.AgentUseCaseInsight.t()] | nil,
          upvotesTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          weeklyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          weeklyActiveUsers: integer | nil
        }

  defstruct [
    :agentUsersInsights,
    :agentsTimeSavedInsights,
    :agentsUsageByDepartmentInsights,
    :dailyActiveUserTimeseries,
    :dailyAgentRunsTimeseries,
    :downvotesTimeseries,
    :failedRunsTimeseries,
    :monthlyActiveUserTimeseries,
    :monthlyActiveUsers,
    :pausedRunsTimeseries,
    :sharedAgentsCount,
    :successfulRunsTimeseries,
    :topAgentsInsights,
    :topUseCasesInsights,
    :upvotesTimeseries,
    :weeklyActiveUserTimeseries,
    :weeklyActiveUsers
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agentUsersInsights: [{Gleanex.Client.AgentUsersInsight, :t}],
      agentsTimeSavedInsights: [{Gleanex.Client.AgentsTimeSavedInsight, :t}],
      agentsUsageByDepartmentInsights: [{Gleanex.Client.AgentsUsageByDepartmentInsight, :t}],
      dailyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      dailyAgentRunsTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      downvotesTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      failedRunsTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      monthlyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      monthlyActiveUsers: :integer,
      pausedRunsTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      sharedAgentsCount: :integer,
      successfulRunsTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      topAgentsInsights: [{Gleanex.Client.PerAgentInsight, :t}],
      topUseCasesInsights: [{Gleanex.Client.AgentUseCaseInsight, :t}],
      upvotesTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      weeklyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      weeklyActiveUsers: :integer
    ]
  end
end
