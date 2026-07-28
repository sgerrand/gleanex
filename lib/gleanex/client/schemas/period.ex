defmodule Gleanex.Client.Period do
  @moduledoc """
  Provides struct and type for a Period
  """

  @type t :: %__MODULE__{
          end: Gleanex.Client.TimePoint.t() | nil,
          maxDaysFromNow: integer | nil,
          minDaysFromNow: integer | nil,
          start: Gleanex.Client.TimePoint.t() | nil
        }

  defstruct [:end, :maxDaysFromNow, :minDaysFromNow, :start]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      end: {Gleanex.Client.TimePoint, :t},
      maxDaysFromNow: :integer,
      minDaysFromNow: :integer,
      start: {Gleanex.Client.TimePoint, :t}
    ]
  end
end
