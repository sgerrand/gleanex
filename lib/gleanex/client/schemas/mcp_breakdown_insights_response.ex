defmodule Gleanex.Client.McpBreakdownInsightsResponse do
  @moduledoc """
  Provides struct and type for a McpBreakdownInsightsResponse
  """

  @type t :: %__MODULE__{
          hostApplicationsBreakdown: [Gleanex.Client.McpHostApplicationBreakdown.t()] | nil,
          serversBreakdown: [Gleanex.Client.McpServerBreakdown.t()] | nil,
          toolsBreakdown: [Gleanex.Client.McpToolBreakdown.t()] | nil,
          usersBreakdown: [Gleanex.Client.McpUserBreakdown.t()] | nil
        }

  defstruct [:hostApplicationsBreakdown, :serversBreakdown, :toolsBreakdown, :usersBreakdown]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      hostApplicationsBreakdown: [{Gleanex.Client.McpHostApplicationBreakdown, :t}],
      serversBreakdown: [{Gleanex.Client.McpServerBreakdown, :t}],
      toolsBreakdown: [{Gleanex.Client.McpToolBreakdown, :t}],
      usersBreakdown: [{Gleanex.Client.McpUserBreakdown, :t}]
    ]
  end
end
