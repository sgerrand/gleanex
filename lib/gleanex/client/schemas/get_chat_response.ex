defmodule Gleanex.Client.GetChatResponse do
  @moduledoc """
  Provides struct and type for a GetChatResponse
  """

  @type t :: %__MODULE__{
          chatResult: Gleanex.Client.ChatResult.t() | nil,
          pagination: Gleanex.Client.GetChatPagination.t() | nil
        }

  defstruct [:chatResult, :pagination]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      chatResult: {Gleanex.Client.ChatResult, :t},
      pagination: {Gleanex.Client.GetChatPagination, :t}
    ]
  end
end
