defmodule Gleanex.Indexing.DebugDatasourceStatusResponseDocuments do
  @moduledoc """
  Provides struct and type for a DebugDatasourceStatusResponseDocuments
  """

  @type t :: %__MODULE__{
          bulkUploadHistory: [Gleanex.Indexing.BulkUploadHistoryEvent.t()] | nil,
          counts: Gleanex.Indexing.DebugDatasourceStatusResponseDocumentsCounts.t() | nil,
          processingHistory: [Gleanex.Indexing.ProcessingHistoryEvent.t()] | nil
        }

  defstruct [:bulkUploadHistory, :counts, :processingHistory]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      bulkUploadHistory: [{Gleanex.Indexing.BulkUploadHistoryEvent, :t}],
      counts: {Gleanex.Indexing.DebugDatasourceStatusResponseDocumentsCounts, :t},
      processingHistory: [{Gleanex.Indexing.ProcessingHistoryEvent, :t}]
    ]
  end
end
