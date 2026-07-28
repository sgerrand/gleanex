defmodule Gleanex.Client.GetDocumentsByFacetsResponse do
  @moduledoc """
  Provides struct and type for a GetDocumentsByFacetsResponse
  """

  @type t :: %__MODULE__{
          cursor: String.t() | nil,
          documents: [Gleanex.Client.Document.t()] | nil,
          hasMoreResults: boolean | nil
        }

  defstruct [:cursor, :documents, :hasMoreResults]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [cursor: :string, documents: [{Gleanex.Client.Document, :t}], hasMoreResults: :boolean]
  end
end
