defmodule Gleanex.Client.PerUserAssistantInsight do
  @moduledoc """
  Provides struct and type for a PerUserAssistantInsight
  """

  @type t :: %__MODULE__{
          numAiAnswers: integer | nil,
          numChatMessages: integer | nil,
          numDaysActive: integer | nil,
          numGleanbotInteractions: integer | nil,
          numSummarizations: integer | nil,
          person: Gleanex.Client.Person.t() | nil
        }

  defstruct [
    :numAiAnswers,
    :numChatMessages,
    :numDaysActive,
    :numGleanbotInteractions,
    :numSummarizations,
    :person
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      numAiAnswers: :integer,
      numChatMessages: :integer,
      numDaysActive: :integer,
      numGleanbotInteractions: :integer,
      numSummarizations: :integer,
      person: {Gleanex.Client.Person, :t}
    ]
  end
end
