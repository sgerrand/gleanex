defmodule Gleanex.Client.AnonymousEvent do
  @moduledoc """
  Provides struct and type for a AnonymousEvent
  """

  @type t :: %__MODULE__{eventType: String.t() | nil, time: Gleanex.Client.TimeInterval.t() | nil}

  defstruct [:eventType, :time]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [eventType: {:enum, ["DEFAULT", "OUT_OF_OFFICE"]}, time: {Gleanex.Client.TimeInterval, :t}]
  end
end
