defmodule Gleanex.Client.ListCollectionsResponse do
  @moduledoc """
  Provides struct and type for a ListCollectionsResponse
  """

  @type t :: %__MODULE__{collections: [Gleanex.Client.Collection.t()]}

  defstruct [:collections]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [collections: [{Gleanex.Client.Collection, :t}]]
  end
end
