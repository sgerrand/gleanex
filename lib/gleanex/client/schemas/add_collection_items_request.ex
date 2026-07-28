defmodule Gleanex.Client.AddCollectionItemsRequest do
  @moduledoc """
  Provides struct and type for a AddCollectionItemsRequest
  """

  @type t :: %__MODULE__{
          addedCollectionItemDescriptors: [Gleanex.Client.CollectionItemDescriptor.t()] | nil,
          collectionId: number
        }

  defstruct [:addedCollectionItemDescriptors, :collectionId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      addedCollectionItemDescriptors: [{Gleanex.Client.CollectionItemDescriptor, :t}],
      collectionId: :number
    ]
  end
end
