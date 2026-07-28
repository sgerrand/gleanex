defmodule Gleanex.Indexing.CustomProperty do
  @moduledoc """
  Provides struct and type for a CustomProperty
  """

  @type t :: %__MODULE__{name: String.t() | nil, value: map | nil}

  defstruct [:name, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [name: :string, value: :map]
  end
end
