defmodule Gleanex.Client.FacetFilterSet do
  @moduledoc """
  Provides struct and type for a FacetFilterSet
  """

  @type t :: %__MODULE__{filters: [Gleanex.Client.FacetFilter.t()] | nil}

  defstruct [:filters]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [filters: [{Gleanex.Client.FacetFilter, :t}]]
  end
end
