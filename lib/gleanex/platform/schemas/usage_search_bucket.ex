defmodule Gleanex.Platform.UsageSearchBucket do
  @moduledoc """
  Provides struct and type for a UsageSearchBucket
  """

  @type t :: %__MODULE__{
          dimensions: Gleanex.Platform.UsageSearchDimensions.t(),
          event_count: integer | nil,
          period: Gleanex.Platform.UsageSearchTimeRange.t() | nil,
          used_by_unit: [Gleanex.Platform.UsageUsedValue.t()]
        }

  defstruct [:dimensions, :event_count, :period, :used_by_unit]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      dimensions: {Gleanex.Platform.UsageSearchDimensions, :t},
      event_count: {:integer, "int64"},
      period: {Gleanex.Platform.UsageSearchTimeRange, :t},
      used_by_unit: [{Gleanex.Platform.UsageUsedValue, :t}]
    ]
  end
end
