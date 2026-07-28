defmodule Gleanex.Indexing.UserStatusResponse do
  @moduledoc """
  Provides struct and type for a UserStatusResponse
  """

  @type t :: %__MODULE__{
          isActiveUser: boolean | nil,
          lastUploadedAt: String.t() | nil,
          uploadStatus: String.t() | nil
        }

  defstruct [:isActiveUser, :lastUploadedAt, :uploadStatus]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      isActiveUser: :boolean,
      lastUploadedAt: :string,
      uploadStatus: {:enum, ["UPLOADED", "NOT_UPLOADED", "STATUS_UNKNOWN"]}
    ]
  end
end
