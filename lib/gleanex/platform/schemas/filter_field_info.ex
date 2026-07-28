defmodule Gleanex.Platform.FilterFieldInfo do
  @moduledoc """
  Provides struct and type for a FilterFieldInfo
  """

  @type t :: %__MODULE__{
          field: String.t(),
          operators: [String.t()],
          type: String.t(),
          values: [String.t()] | nil
        }

  defstruct [:field, :operators, :type, :values]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      field: :string,
      operators: [enum: ["EQUALS", "NOT_EQUALS", "GT", "GTE", "LT", "LTE"]],
      type: :string,
      values: [:string]
    ]
  end
end
