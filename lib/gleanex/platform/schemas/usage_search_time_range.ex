defmodule Gleanex.Platform.UsageSearchTimeRange do
  @moduledoc """
  Provides struct and type for a UsageSearchTimeRange
  """

  @type t :: %__MODULE__{end: DateTime.t(), start: DateTime.t()}

  defstruct [:end, :start]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [end: {:string, "date-time"}, start: {:string, "date-time"}]
  end
end
