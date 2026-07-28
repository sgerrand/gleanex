defmodule Gleanex.Client.TimeInterval do
  @moduledoc """
  Provides struct and type for a TimeInterval
  """

  @type t :: %__MODULE__{end: String.t(), start: String.t()}

  defstruct [:end, :start]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [end: :string, start: :string]
  end
end
