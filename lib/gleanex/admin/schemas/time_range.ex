defmodule Gleanex.Admin.TimeRange do
  @moduledoc """
  Provides struct and type for a TimeRange
  """

  @type t :: %__MODULE__{
          endTime: DateTime.t() | nil,
          lastNDaysValue: integer | nil,
          startTime: DateTime.t() | nil
        }

  defstruct [:endTime, :lastNDaysValue, :startTime]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      endTime: {:string, "date-time"},
      lastNDaysValue: {:integer, "int64"},
      startTime: {:string, "date-time"}
    ]
  end
end
