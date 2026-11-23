defmodule Gleanex.Platform.UsageSearchSort do
  @moduledoc """
  Provides struct and type for a UsageSearchSort
  """

  @type t :: %__MODULE__{direction: String.t(), field: String.t(), unit: String.t() | nil}

  defstruct [:direction, :field, :unit]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      direction: {:enum, ["ASC", "DESC"]},
      field: {:enum, ["USED", "PERIOD_START"]},
      unit: {:enum, ["USD", "CREDITS"]}
    ]
  end
end
