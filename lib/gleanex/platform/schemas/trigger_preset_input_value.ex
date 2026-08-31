defmodule Gleanex.Platform.TriggerPresetInputValue do
  @moduledoc """
  Provides struct and type for a TriggerPresetInputValue
  """

  @type t :: %__MODULE__{display_name: String.t(), value: String.t()}

  defstruct [:display_name, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [display_name: :string, value: :string]
  end
end
