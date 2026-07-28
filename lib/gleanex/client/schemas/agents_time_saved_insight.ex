defmodule Gleanex.Client.AgentsTimeSavedInsight do
  @moduledoc """
  Provides struct and type for a AgentsTimeSavedInsight
  """

  @type t :: %__MODULE__{
          agentId: String.t() | nil,
          agentName: String.t() | nil,
          feedbackUserCount: integer | nil,
          icon: Gleanex.Client.IconConfig.t() | nil,
          isDeleted: boolean | nil,
          minsPerRun: number | nil,
          runCount: integer | nil
        }

  defstruct [:agentId, :agentName, :feedbackUserCount, :icon, :isDeleted, :minsPerRun, :runCount]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agentId: :string,
      agentName: :string,
      feedbackUserCount: :integer,
      icon: {Gleanex.Client.IconConfig, :t},
      isDeleted: :boolean,
      minsPerRun: {:number, "float"},
      runCount: :integer
    ]
  end
end
