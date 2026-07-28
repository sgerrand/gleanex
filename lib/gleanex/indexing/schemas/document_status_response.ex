defmodule Gleanex.Indexing.DocumentStatusResponse do
  @moduledoc """
  Provides struct and type for a DocumentStatusResponse
  """

  @type t :: %__MODULE__{
          indexingStatus: String.t() | nil,
          lastIndexedAt: String.t() | nil,
          lastUploadedAt: String.t() | nil,
          permissionIdentityStatus: String.t() | nil,
          uploadStatus: String.t() | nil
        }

  defstruct [
    :indexingStatus,
    :lastIndexedAt,
    :lastUploadedAt,
    :permissionIdentityStatus,
    :uploadStatus
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      indexingStatus: :string,
      lastIndexedAt: :string,
      lastUploadedAt: :string,
      permissionIdentityStatus: :string,
      uploadStatus: :string
    ]
  end
end
