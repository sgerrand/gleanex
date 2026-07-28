defmodule Gleanex.Client.EditCollectionItemResponse do
  @moduledoc """
  Provides struct and type for a EditCollectionItemResponse
  """

  @type t :: %__MODULE__{collection: Gleanex.Client.Collection.t() | nil}

  defstruct [:collection]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [collection: {Gleanex.Client.Collection, :t}]
  end
end
