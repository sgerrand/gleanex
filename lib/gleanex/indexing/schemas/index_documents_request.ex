defmodule Gleanex.Indexing.IndexDocumentsRequest do
  @moduledoc """
  Provides struct and type for a IndexDocumentsRequest
  """

  @type t :: %__MODULE__{
          datasource: String.t(),
          documents: [Gleanex.Indexing.DocumentDefinition.t()],
          uploadId: String.t() | nil
        }

  defstruct [:datasource, :documents, :uploadId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasource: :string,
      documents: [{Gleanex.Indexing.DocumentDefinition, :t}],
      uploadId: :string
    ]
  end
end
