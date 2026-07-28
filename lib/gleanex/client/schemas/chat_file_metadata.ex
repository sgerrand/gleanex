defmodule Gleanex.Client.ChatFileMetadata do
  @moduledoc """
  Provides struct and type for a ChatFileMetadata
  """

  @type t :: %__MODULE__{
          failureReason: String.t() | nil,
          mimeType: String.t() | nil,
          processedSize: integer | nil,
          status: String.t() | nil,
          uploadTime: integer | nil
        }

  defstruct [:failureReason, :mimeType, :processedSize, :status, :uploadTime]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      failureReason:
        {:enum,
         [
           "PARSE_FAILED",
           "AV_SCAN_FAILED",
           "FILE_TOO_SMALL",
           "FILE_TOO_LARGE",
           "FILE_EXTENSION_UNSUPPORTED",
           "FILE_METADATA_VALIDATION_FAIL",
           "FILE_PROCESSING_TIMED_OUT",
           "OAUTH_NEEDED",
           "URL_FETCH_FAILED",
           "EMPTY_CONTENT",
           "AUTH_REQUIRED"
         ]},
      mimeType: :string,
      processedSize: {:integer, "int64"},
      status: {:enum, ["PROCESSING", "PROCESSED", "PARTIALLY_PROCESSED", "FAILED", "DELETED"]},
      uploadTime: {:integer, "int64"}
    ]
  end
end
