defmodule Gleanex.Client.AddCollectionItemsError do
  @moduledoc """
  Provides struct and type for a AddCollectionItemsError
  """

  @type t :: %__MODULE__{errorType: String.t() | nil}

  defstruct [:errorType]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [errorType: {:enum, ["EXISTING_ITEM", "CORRUPT_ITEM"]}]
  end
end
