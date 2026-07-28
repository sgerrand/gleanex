defmodule Gleanex.Client.EditCollectionResponse do
  @moduledoc """
  Provides struct and type for a EditCollectionResponse
  """

  @type t :: %__MODULE__{
          collection: Gleanex.Client.Collection.t() | nil,
          error: Gleanex.Client.CollectionError.t() | nil,
          errorCode: String.t() | nil
        }

  defstruct [:collection, :error, :errorCode]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      collection: {Gleanex.Client.Collection, :t},
      error: {Gleanex.Client.CollectionError, :t},
      errorCode:
        {:enum,
         [
           "NAME_EXISTS",
           "NOT_FOUND",
           "COLLECTION_PINNED",
           "CONCURRENT_HIERARCHY_EDIT",
           "HEIGHT_VIOLATION",
           "WIDTH_VIOLATION",
           "NO_PERMISSIONS",
           "CORRUPT_ITEM"
         ]}
    ]
  end
end
