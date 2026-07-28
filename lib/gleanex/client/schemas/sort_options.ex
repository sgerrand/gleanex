defmodule Gleanex.Client.SortOptions do
  @moduledoc """
  Provides struct and type for a SortOptions
  """

  @type t :: %__MODULE__{orderBy: String.t() | nil, sortBy: String.t() | nil}

  defstruct [:orderBy, :sortBy]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [orderBy: {:enum, ["ASC", "DESC"]}, sortBy: :string]
  end
end
