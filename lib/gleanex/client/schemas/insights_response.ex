defmodule Gleanex.Client.InsightsResponse do
  @moduledoc """
  Provides struct and type for a InsightsResponse
  """

  @type t :: %__MODULE__{
          agentsResponse: Gleanex.Client.AgentsInsightsV2Response.t() | nil,
          assistantResponse: Gleanex.Client.AssistantInsightsResponse.t() | nil,
          gleanAssist: Gleanex.Client.GleanAssistInsightsResponse.t() | nil,
          mcpBreakdownResponse: Gleanex.Client.McpBreakdownInsightsResponse.t() | nil,
          mcpResponse: Gleanex.Client.McpInsightsResponse.t() | nil,
          overviewResponse: Gleanex.Client.InsightsOverviewResponse.t() | nil
        }

  defstruct [
    :agentsResponse,
    :assistantResponse,
    :gleanAssist,
    :mcpBreakdownResponse,
    :mcpResponse,
    :overviewResponse
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agentsResponse: {Gleanex.Client.AgentsInsightsV2Response, :t},
      assistantResponse: {Gleanex.Client.AssistantInsightsResponse, :t},
      gleanAssist: {Gleanex.Client.GleanAssistInsightsResponse, :t},
      mcpBreakdownResponse: {Gleanex.Client.McpBreakdownInsightsResponse, :t},
      mcpResponse: {Gleanex.Client.McpInsightsResponse, :t},
      overviewResponse: {Gleanex.Client.InsightsOverviewResponse, :t}
    ]
  end
end
