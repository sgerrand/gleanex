defmodule Gleanex.Client.CreateCollectionResponse do
  @moduledoc """
  Provides struct and type for a CreateCollectionResponse
  """

  @type t :: %__MODULE__{
          collection: Gleanex.Client.Collection.t() | nil,
          error: Gleanex.Client.CollectionError.t() | nil
        }

  defstruct [:collection, :error]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [collection: {Gleanex.Client.Collection, :t}, error: {Gleanex.Client.CollectionError, :t}]
  end
end
