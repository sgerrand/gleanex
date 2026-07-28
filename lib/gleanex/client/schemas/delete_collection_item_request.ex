defmodule Gleanex.Client.DeleteCollectionItemRequest do
  @moduledoc """
  Provides struct and type for a DeleteCollectionItemRequest
  """

  @type t :: %__MODULE__{collectionId: number, documentId: String.t() | nil, itemId: String.t()}

  defstruct [:collectionId, :documentId, :itemId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [collectionId: :number, documentId: :string, itemId: :string]
  end
end
