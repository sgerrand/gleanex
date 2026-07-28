defmodule Gleanex.Client.ChatResult do
  @moduledoc """
  Provides struct and type for a ChatResult
  """

  @type t :: %__MODULE__{chat: Gleanex.Client.Chat.t() | nil, trackingToken: String.t() | nil}

  defstruct [:chat, :trackingToken]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [chat: {Gleanex.Client.Chat, :t}, trackingToken: :string]
  end
end
