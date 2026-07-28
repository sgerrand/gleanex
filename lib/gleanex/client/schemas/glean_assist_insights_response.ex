defmodule Gleanex.Client.GleanAssistInsightsResponse do
  @moduledoc """
  Provides struct and type for a GleanAssistInsightsResponse
  """

  @type t :: %__MODULE__{
          activityInsights: [Gleanex.Client.UserActivityInsight.t()] | nil,
          datasourceInstances: [String.t()] | nil,
          departments: [String.t()] | nil,
          lastLogTimestamp: integer | nil,
          totalActiveUsers: integer | nil
        }

  defstruct [
    :activityInsights,
    :datasourceInstances,
    :departments,
    :lastLogTimestamp,
    :totalActiveUsers
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      activityInsights: [{Gleanex.Client.UserActivityInsight, :t}],
      datasourceInstances: [:string],
      departments: [:string],
      lastLogTimestamp: :integer,
      totalActiveUsers: :integer
    ]
  end
end
