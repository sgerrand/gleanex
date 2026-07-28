defmodule Gleanex.Client.McpBreakdownInsightsRequest do
  @moduledoc """
  Provides struct and type for a McpBreakdownInsightsRequest
  """

  @type t :: %__MODULE__{
          breakdownType: String.t() | nil,
          dayRange: Gleanex.Client.Period.t() | nil,
          departments: [String.t()] | nil,
          hostApplications: [String.t()] | nil,
          managerEmails: [String.t()] | nil,
          managerIds: [String.t()] | nil,
          servers: [String.t()] | nil,
          tools: [String.t()] | nil
        }

  defstruct [
    :breakdownType,
    :dayRange,
    :departments,
    :hostApplications,
    :managerEmails,
    :managerIds,
    :servers,
    :tools
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      breakdownType: {:enum, ["USERS", "HOST_APPLICATIONS", "TOOLS", "SERVERS"]},
      dayRange: {Gleanex.Client.Period, :t},
      departments: [:string],
      hostApplications: [:string],
      managerEmails: [:string],
      managerIds: [:string],
      servers: [:string],
      tools: [:string]
    ]
  end
end
