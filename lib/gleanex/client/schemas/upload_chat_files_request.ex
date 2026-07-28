defmodule Gleanex.Client.UploadChatFilesRequest do
  @moduledoc """
  Provides struct and type for a UploadChatFilesRequest
  """

  @type t :: %__MODULE__{files: [binary]}

  defstruct [:files]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [files: [string: "binary"]]
  end
end
