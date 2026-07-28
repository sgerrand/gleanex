defmodule Gleanex.Client.ChatFile do
  @moduledoc """
  Provides struct and type for a ChatFile
  """

  @type t :: %__MODULE__{
          id: String.t() | nil,
          metadata: Gleanex.Client.ChatFileMetadata.t() | nil,
          name: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [:id, :metadata, :name, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: :string, metadata: {Gleanex.Client.ChatFileMetadata, :t}, name: :string, url: :string]
  end
end
