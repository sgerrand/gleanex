defmodule Gleanex.Client.AgentsInsightsV2Request do
  @moduledoc """
  Provides struct and type for a AgentsInsightsV2Request
  """

  @type t :: %__MODULE__{
          agentIds: [String.t()] | nil,
          dayRange: Gleanex.Client.Period.t() | nil,
          departments: [String.t()] | nil,
          managerEmails: [String.t()] | nil
        }

  defstruct [:agentIds, :dayRange, :departments, :managerEmails]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agentIds: [:string],
      dayRange: {Gleanex.Client.Period, :t},
      departments: [:string],
      managerEmails: [:string]
    ]
  end
end
