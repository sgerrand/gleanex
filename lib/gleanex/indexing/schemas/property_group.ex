defmodule Gleanex.Indexing.PropertyGroup do
  @moduledoc """
  Provides struct and type for a PropertyGroup
  """

  @type t :: %__MODULE__{displayLabel: String.t() | nil, name: String.t() | nil}

  defstruct [:displayLabel, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [displayLabel: :string, name: :string]
  end
end
