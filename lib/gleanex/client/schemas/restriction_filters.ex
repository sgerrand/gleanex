defmodule Gleanex.Client.RestrictionFilters do
  @moduledoc """
  Provides struct and type for a RestrictionFilters
  """

  @type t :: %__MODULE__{containerSpecs: [map] | nil}

  defstruct [:containerSpecs]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [containerSpecs: [:map]]
  end
end
