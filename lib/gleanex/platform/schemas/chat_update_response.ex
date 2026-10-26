defmodule Gleanex.Platform.ChatUpdateResponse do
  @moduledoc """
  Provides struct and type for a ChatUpdateResponse
  """

  @type t :: %__MODULE__{chat: Gleanex.Platform.Chat.t(), request_id: String.t()}

  defstruct [:chat, :request_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [chat: {Gleanex.Platform.Chat, :t}, request_id: :string]
  end
end
