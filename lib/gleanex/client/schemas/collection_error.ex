defmodule Gleanex.Client.CollectionError do
  @moduledoc """
  Provides struct and type for a CollectionError
  """

  @type t :: %__MODULE__{errorCode: String.t()}

  defstruct [:errorCode]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
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
