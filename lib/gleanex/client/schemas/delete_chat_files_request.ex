defmodule Gleanex.Client.DeleteChatFilesRequest do
  @moduledoc """
  Provides struct and type for a DeleteChatFilesRequest
  """

  @type t :: %__MODULE__{fileIds: [String.t()]}

  defstruct [:fileIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [fileIds: [:string]]
  end
end
