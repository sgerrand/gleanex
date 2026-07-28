defmodule Gleanex.Client.McpInsightsRequest do
  @moduledoc """
  Provides struct and type for a McpInsightsRequest
  """

  @type t :: %__MODULE__{
          dayRange: Gleanex.Client.Period.t() | nil,
          departments: [String.t()] | nil,
          managerEmails: [String.t()] | nil,
          managerIds: [String.t()] | nil
        }

  defstruct [:dayRange, :departments, :managerEmails, :managerIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      dayRange: {Gleanex.Client.Period, :t},
      departments: [:string],
      managerEmails: [:string],
      managerIds: [:string]
    ]
  end
end
