defmodule Gleanex.Client.UploadChatFilesResponse do
  @moduledoc """
  Provides struct and type for a UploadChatFilesResponse
  """

  @type t :: %__MODULE__{files: [Gleanex.Client.ChatFile.t()] | nil}

  defstruct [:files]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [files: [{Gleanex.Client.ChatFile, :t}]]
  end
end
