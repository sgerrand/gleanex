defmodule Gleanex.Client.ChatMetadataResult do
  @moduledoc """
  Provides struct and type for a ChatMetadataResult
  """

  @type t :: %__MODULE__{
          chat: Gleanex.Client.ChatMetadata.t() | nil,
          trackingToken: String.t() | nil
        }

  defstruct [:chat, :trackingToken]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [chat: {Gleanex.Client.ChatMetadata, :t}, trackingToken: :string]
  end
end
