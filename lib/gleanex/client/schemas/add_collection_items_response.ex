defmodule Gleanex.Client.AddCollectionItemsResponse do
  @moduledoc """
  Provides struct and type for a AddCollectionItemsResponse
  """

  @type t :: %__MODULE__{
          collection: Gleanex.Client.Collection.t() | nil,
          error: Gleanex.Client.AddCollectionItemsError.t() | nil
        }

  defstruct [:collection, :error]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      collection: {Gleanex.Client.Collection, :t},
      error: {Gleanex.Client.AddCollectionItemsError, :t}
    ]
  end
end
