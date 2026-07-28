defmodule Gleanex.Client.ChatResponse do
  @moduledoc """
  Provides struct and type for a ChatResponse
  """

  @type t :: %__MODULE__{
          backendTimeMillis: integer | nil,
          chat: Gleanex.Client.ChatMetadata.t() | nil,
          chatId: String.t() | nil,
          chatSessionTrackingToken: String.t() | nil,
          followUpPrompts: [String.t()] | nil,
          messages: [Gleanex.Client.ChatMessage.t()] | nil
        }

  defstruct [
    :backendTimeMillis,
    :chat,
    :chatId,
    :chatSessionTrackingToken,
    :followUpPrompts,
    :messages
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      backendTimeMillis: {:integer, "int64"},
      chat: {Gleanex.Client.ChatMetadata, :t},
      chatId: :string,
      chatSessionTrackingToken: :string,
      followUpPrompts: [:string],
      messages: [{Gleanex.Client.ChatMessage, :t}]
    ]
  end
end
