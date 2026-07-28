defmodule Gleanex.Indexing.BulkUploadHistoryEvent do
  @moduledoc """
  Provides struct and type for a BulkUploadHistoryEvent
  """

  @type t :: %__MODULE__{
          endTime: String.t() | nil,
          processingState: String.t() | nil,
          startTime: String.t() | nil,
          status: String.t() | nil,
          uploadId: String.t() | nil
        }

  defstruct [:endTime, :processingState, :startTime, :status, :uploadId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      endTime: :string,
      processingState:
        {:enum,
         [
           "UNAVAILABLE",
           "UPLOAD STARTED",
           "UPLOAD IN PROGRESS",
           "UPLOAD COMPLETED",
           "DELETION PAUSED",
           "INDEXING COMPLETED"
         ]},
      startTime: :string,
      status: {:enum, ["ACTIVE", "SUCCESSFUL"]},
      uploadId: :string
    ]
  end
end
