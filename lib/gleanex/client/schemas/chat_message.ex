defmodule Gleanex.Client.ChatMessage do
  @moduledoc """
  Provides struct and type for a ChatMessage
  """

  @type t :: %__MODULE__{
          agentConfig: Gleanex.Client.AgentConfig.t() | nil,
          author: String.t() | nil,
          citations: [Gleanex.Client.ChatMessageCitation.t()] | nil,
          fragments: [Gleanex.Client.ChatMessageFragment.t()] | nil,
          hasMoreFragments: boolean | nil,
          messageId: String.t() | nil,
          messageTrackingToken: String.t() | nil,
          messageType: String.t() | nil,
          ts: String.t() | nil,
          uploadedFileIds: [String.t()] | nil
        }

  defstruct [
    :agentConfig,
    :author,
    :citations,
    :fragments,
    :hasMoreFragments,
    :messageId,
    :messageTrackingToken,
    :messageType,
    :ts,
    :uploadedFileIds
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agentConfig: {Gleanex.Client.AgentConfig, :t},
      author: {:enum, ["USER", "GLEAN_AI"]},
      citations: [{Gleanex.Client.ChatMessageCitation, :t}],
      fragments: [{Gleanex.Client.ChatMessageFragment, :t}],
      hasMoreFragments: :boolean,
      messageId: :string,
      messageTrackingToken: :string,
      messageType:
        {:enum,
         [
           "UPDATE",
           "CONTENT",
           "CONTEXT",
           "CONTROL",
           "CONTROL_START",
           "CONTROL_FINISH",
           "CONTROL_CANCEL",
           "CONTROL_RETRY",
           "CONTROL_UNKNOWN",
           "DEBUG",
           "DEBUG_EXTERNAL",
           "ERROR",
           "HEADING",
           "WARNING",
           "SERVER_TOOL"
         ]},
      ts: :string,
      uploadedFileIds: [:string]
    ]
  end
end
