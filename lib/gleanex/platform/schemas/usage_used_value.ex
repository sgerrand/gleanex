defmodule Gleanex.Platform.UsageUsedValue do
  @moduledoc """
  Provides struct and type for a UsageUsedValue
  """

  @type t :: %__MODULE__{unit: String.t(), used: String.t()}

  defstruct [:unit, :used]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [unit: {:enum, ["USD", "CREDITS"]}, used: :string]
  end
end
