defmodule Gleanex.Indexing.BulkIndexDocumentsRequest do
  @moduledoc """
  Provides struct and type for a BulkIndexDocumentsRequest
  """

  @type t :: %__MODULE__{
          datasource: String.t() | nil,
          disableStaleDocumentDeletionCheck: boolean | nil,
          documents: [Gleanex.Indexing.DocumentDefinition.t()] | nil,
          forceRestartUpload: boolean | nil,
          isFirstPage: boolean | nil,
          isLastPage: boolean | nil,
          uploadId: String.t() | nil
        }

  defstruct [
    :datasource,
    :disableStaleDocumentDeletionCheck,
    :documents,
    :forceRestartUpload,
    :isFirstPage,
    :isLastPage,
    :uploadId
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasource: :string,
      disableStaleDocumentDeletionCheck: :boolean,
      documents: [{Gleanex.Indexing.DocumentDefinition, :t}],
      forceRestartUpload: :boolean,
      isFirstPage: :boolean,
      isLastPage: :boolean,
      uploadId: :string
    ]
  end
end
