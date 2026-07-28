defmodule Gleanex.Indexing.DebugDatasourceStatusIdentityResponseComponent do
  @moduledoc """
  Provides struct and type for a DebugDatasourceStatusIdentityResponseComponent
  """

  @type t :: %__MODULE__{
          bulkUploadHistory: [Gleanex.Indexing.BulkUploadHistoryEvent.t()] | nil,
          counts: Gleanex.Indexing.DebugDatasourceStatusIdentityResponseComponentCounts.t() | nil
        }

  defstruct [:bulkUploadHistory, :counts]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      bulkUploadHistory: [{Gleanex.Indexing.BulkUploadHistoryEvent, :t}],
      counts: {Gleanex.Indexing.DebugDatasourceStatusIdentityResponseComponentCounts, :t}
    ]
  end
end
