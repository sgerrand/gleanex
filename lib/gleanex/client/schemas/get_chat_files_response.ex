defmodule Gleanex.Client.GetChatFilesResponse do
  @moduledoc """
  Provides struct and type for a GetChatFilesResponse
  """

  @type t :: %__MODULE__{files: map | nil}

  defstruct [:files]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [files: :map]
  end
end
