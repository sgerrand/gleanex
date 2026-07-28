defmodule Gleanex.Client.TimePoint do
  @moduledoc """
  Provides struct and type for a TimePoint
  """

  @type t :: %__MODULE__{daysFromNow: integer | nil, epochSeconds: integer | nil}

  defstruct [:daysFromNow, :epochSeconds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [daysFromNow: :integer, epochSeconds: :integer]
  end
end
