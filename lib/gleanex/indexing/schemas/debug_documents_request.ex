defmodule Gleanex.Indexing.DebugDocumentsRequest do
  @moduledoc """
  Provides struct and type for a DebugDocumentsRequest
  """

  @type t :: %__MODULE__{debugDocuments: [Gleanex.Indexing.DebugDocumentRequest.t()]}

  defstruct [:debugDocuments]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [debugDocuments: [{Gleanex.Indexing.DebugDocumentRequest, :t}]]
  end
end
