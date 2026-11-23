defmodule Gleanex.Platform.UsageAggregateUsage do
  @moduledoc """
  Provides struct and type for a UsageAggregateUsage
  """

  @type t :: %__MODULE__{used_by_unit: [Gleanex.Platform.UsageUsedValue.t()]}

  defstruct [:used_by_unit]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [used_by_unit: [{Gleanex.Platform.UsageUsedValue, :t}]]
  end
end
