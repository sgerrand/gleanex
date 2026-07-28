defmodule Gleanex.Indexing.DebugDocumentsResponseItem do
  @moduledoc """
  Provides struct and type for a DebugDocumentsResponseItem
  """

  @type t :: %__MODULE__{
          debugInfo: Gleanex.Indexing.DebugDocumentResponse.t() | nil,
          docId: String.t() | nil,
          objectType: String.t() | nil
        }

  defstruct [:debugInfo, :docId, :objectType]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [debugInfo: {Gleanex.Indexing.DebugDocumentResponse, :t}, docId: :string, objectType: :string]
  end
end
