defmodule Gleanex.Client.GetCollectionResponse do
  @moduledoc """
  Provides struct and type for a GetCollectionResponse
  """

  @type t :: %__MODULE__{
          collection: Gleanex.Client.Collection.t() | nil,
          error: Gleanex.Client.CollectionError.t() | nil,
          rootCollection: Gleanex.Client.Collection.t() | nil,
          trackingToken: String.t() | nil
        }

  defstruct [:collection, :error, :rootCollection, :trackingToken]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      collection: {Gleanex.Client.Collection, :t},
      error: {Gleanex.Client.CollectionError, :t},
      rootCollection: {Gleanex.Client.Collection, :t},
      trackingToken: :string
    ]
  end
end
