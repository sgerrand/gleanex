defmodule Gleanex.Client.FacetFilterValue do
  @moduledoc """
  Provides struct and type for a FacetFilterValue
  """

  @type t :: %__MODULE__{
          isNegated: boolean | nil,
          relationType: String.t() | nil,
          value: String.t() | nil
        }

  defstruct [:isNegated, :relationType, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      isNegated: :boolean,
      relationType: {:enum, ["EQUALS", "ID_EQUALS", "LT", "GT", "NOT_EQUALS"]},
      value: :string
    ]
  end
end
