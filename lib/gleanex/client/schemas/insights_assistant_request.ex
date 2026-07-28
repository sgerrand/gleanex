defmodule Gleanex.Client.InsightsAssistantRequest do
  @moduledoc """
  Provides struct and type for a InsightsAssistantRequest
  """

  @type t :: %__MODULE__{
          dayRange: Gleanex.Client.Period.t() | nil,
          departments: [String.t()] | nil,
          managerEmails: [String.t()] | nil
        }

  defstruct [:dayRange, :departments, :managerEmails]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [dayRange: {Gleanex.Client.Period, :t}, departments: [:string], managerEmails: [:string]]
  end
end
