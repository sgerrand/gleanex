defmodule Gleanex.Admin.TimeRangeFilter do
  @moduledoc """
  Provides struct and type for a TimeRangeFilter
  """

  @type t :: %__MODULE__{
          customTimeRange: Gleanex.Admin.TimeRange.t() | nil,
          timePeriodType: String.t() | nil
        }

  defstruct [:customTimeRange, :timePeriodType]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      customTimeRange: {Gleanex.Admin.TimeRange, :t},
      timePeriodType: {:enum, ["PAST_DAY", "PAST_WEEK", "PAST_MONTH", "PAST_YEAR", "CUSTOM"]}
    ]
  end
end
