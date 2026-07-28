defmodule Gleanex.Client.ChatRequest do
  @moduledoc """
  Provides struct and type for a ChatRequest
  """

  @type t :: %__MODULE__{
          agentConfig: Gleanex.Client.AgentConfig.t() | nil,
          agentId: String.t() | nil,
          applicationId: String.t() | nil,
          chatId: String.t() | nil,
          exclusions: Gleanex.Client.ChatRestrictionFilters.t() | nil,
          inclusions: Gleanex.Client.ChatRestrictionFilters.t() | nil,
          messages: [Gleanex.Client.ChatMessage.t()] | nil,
          saveChat: boolean | nil,
          sessionInfo: Gleanex.Client.SessionInfo.t() | nil,
          stream: boolean | nil,
          timeoutMillis: integer | nil
        }

  defstruct [
    :agentConfig,
    :agentId,
    :applicationId,
    :chatId,
    :exclusions,
    :inclusions,
    :messages,
    :saveChat,
    :sessionInfo,
    :stream,
    :timeoutMillis
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agentConfig: {Gleanex.Client.AgentConfig, :t},
      agentId: :string,
      applicationId: :string,
      chatId: :string,
      exclusions: {Gleanex.Client.ChatRestrictionFilters, :t},
      inclusions: {Gleanex.Client.ChatRestrictionFilters, :t},
      messages: [{Gleanex.Client.ChatMessage, :t}],
      saveChat: :boolean,
      sessionInfo: {Gleanex.Client.SessionInfo, :t},
      stream: :boolean,
      timeoutMillis: :integer
    ]
  end
end
