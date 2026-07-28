defmodule Gleanex.Client.InsightsRequest do
  @moduledoc """
  Provides struct and type for a InsightsRequest
  """

  @type t :: %__MODULE__{
          agentsRequest: Gleanex.Client.AgentsInsightsV2Request.t() | nil,
          assistantRequest: Gleanex.Client.InsightsAssistantRequest.t() | nil,
          disablePerUserInsights: boolean | nil,
          mcpBreakdownRequest: Gleanex.Client.McpBreakdownInsightsRequest.t() | nil,
          mcpRequest: Gleanex.Client.McpInsightsRequest.t() | nil,
          overviewRequest: Gleanex.Client.InsightsOverviewRequest.t() | nil
        }

  defstruct [
    :agentsRequest,
    :assistantRequest,
    :disablePerUserInsights,
    :mcpBreakdownRequest,
    :mcpRequest,
    :overviewRequest
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agentsRequest: {Gleanex.Client.AgentsInsightsV2Request, :t},
      assistantRequest: {Gleanex.Client.InsightsAssistantRequest, :t},
      disablePerUserInsights: :boolean,
      mcpBreakdownRequest: {Gleanex.Client.McpBreakdownInsightsRequest, :t},
      mcpRequest: {Gleanex.Client.McpInsightsRequest, :t},
      overviewRequest: {Gleanex.Client.InsightsOverviewRequest, :t}
    ]
  end
end
