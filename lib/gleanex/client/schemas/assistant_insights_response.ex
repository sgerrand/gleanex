defmodule Gleanex.Client.AssistantInsightsResponse do
  @moduledoc """
  Provides struct and type for a AssistantInsightsResponse
  """

  @type t :: %__MODULE__{
          aiAnswersTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          chatMessagesTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          dailyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          downvotesTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          gleanbotInteractionsTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          lastUpdatedTs: integer | nil,
          monthlyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          monthlyActiveUsers: integer | nil,
          perUserInsights: [Gleanex.Client.PerUserAssistantInsight.t()] | nil,
          summarizationsTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          totalSignups: integer | nil,
          upvotesTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          weeklyActiveUserTimeseries: Gleanex.Client.LabeledCountInfo.t() | nil,
          weeklyActiveUsers: integer | nil
        }

  defstruct [
    :aiAnswersTimeseries,
    :chatMessagesTimeseries,
    :dailyActiveUserTimeseries,
    :downvotesTimeseries,
    :gleanbotInteractionsTimeseries,
    :lastUpdatedTs,
    :monthlyActiveUserTimeseries,
    :monthlyActiveUsers,
    :perUserInsights,
    :summarizationsTimeseries,
    :totalSignups,
    :upvotesTimeseries,
    :weeklyActiveUserTimeseries,
    :weeklyActiveUsers
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      aiAnswersTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      chatMessagesTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      dailyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      downvotesTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      gleanbotInteractionsTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      lastUpdatedTs: :integer,
      monthlyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      monthlyActiveUsers: :integer,
      perUserInsights: [{Gleanex.Client.PerUserAssistantInsight, :t}],
      summarizationsTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      totalSignups: :integer,
      upvotesTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      weeklyActiveUserTimeseries: {Gleanex.Client.LabeledCountInfo, :t},
      weeklyActiveUsers: :integer
    ]
  end
end
