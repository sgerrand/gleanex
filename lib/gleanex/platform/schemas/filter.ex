defmodule Gleanex.Platform.Filter do
  @moduledoc """
  Provides struct and type for a Filter
  """

  @type t :: %__MODULE__{
          field: String.t(),
          operator: Gleanex.Platform.FilterOperator.t() | nil,
          values: [String.t()]
        }

  defstruct [:field, :operator, :values]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [field: :string, operator: {Gleanex.Platform.FilterOperator, :t}, values: [:string]]
  end
end
