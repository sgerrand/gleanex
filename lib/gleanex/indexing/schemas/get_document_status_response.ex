defmodule Gleanex.Indexing.GetDocumentStatusResponse do
  @moduledoc """
  Provides struct and type for a GetDocumentStatusResponse
  """

  @type t :: %__MODULE__{
          indexingStatus: String.t() | nil,
          lastIndexedAt: integer | nil,
          lastUploadedAt: integer | nil,
          uploadStatus: String.t() | nil
        }

  defstruct [:indexingStatus, :lastIndexedAt, :lastUploadedAt, :uploadStatus]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      indexingStatus: :string,
      lastIndexedAt: {:integer, "int64"},
      lastUploadedAt: {:integer, "int64"},
      uploadStatus: :string
    ]
  end
end
