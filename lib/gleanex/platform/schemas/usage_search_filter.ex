defmodule Gleanex.Platform.UsageSearchFilter do
  @moduledoc """
  Provides struct and type for a UsageSearchFilter
  """

  @type t :: %__MODULE__{field: String.t(), operator: String.t() | nil, values: [String.t()]}

  defstruct [:field, :operator, :values]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [field: :string, operator: {:enum, ["EQUALS", "NOT_EQUALS"]}, values: [:string]]
  end
end
