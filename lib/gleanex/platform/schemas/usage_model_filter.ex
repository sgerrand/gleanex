defmodule Gleanex.Platform.UsageModelFilter do
  @moduledoc """
  Provides struct and type for a UsageModelFilter
  """

  @type t :: %__MODULE__{models: [String.t()]}

  defstruct [:models]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [models: [:string]]
  end
end
