defmodule Gleanex.Client.PerUserInsight do
  @moduledoc """
  Provides struct and type for a PerUserInsight
  """

  @type t :: %__MODULE__{
          numActiveSessions: integer | nil,
          numAgentRuns: integer | nil,
          numAiAnswers: integer | nil,
          numChats: integer | nil,
          numDaysActive: integer | nil,
          numGleanbotUsefulResponses: integer | nil,
          numMcpCalls: integer | nil,
          numSearches: integer | nil,
          numSummarizations: integer | nil,
          person: Gleanex.Client.Person.t() | nil
        }

  defstruct [
    :numActiveSessions,
    :numAgentRuns,
    :numAiAnswers,
    :numChats,
    :numDaysActive,
    :numGleanbotUsefulResponses,
    :numMcpCalls,
    :numSearches,
    :numSummarizations,
    :person
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      numActiveSessions: :integer,
      numAgentRuns: :integer,
      numAiAnswers: :integer,
      numChats: :integer,
      numDaysActive: :integer,
      numGleanbotUsefulResponses: :integer,
      numMcpCalls: :integer,
      numSearches: :integer,
      numSummarizations: :integer,
      person: {Gleanex.Client.Person, :t}
    ]
  end
end
