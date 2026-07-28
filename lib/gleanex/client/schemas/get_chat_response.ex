defmodule Gleanex.Client.GetChatResponse do
  @moduledoc """
  Provides struct and type for a GetChatResponse
  """

  @type t :: %__MODULE__{chatResult: Gleanex.Client.ChatResult.t() | nil}

  defstruct [:chatResult]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [chatResult: {Gleanex.Client.ChatResult, :t}]
  end
end
