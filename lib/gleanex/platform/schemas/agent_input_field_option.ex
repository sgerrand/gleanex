defmodule Gleanex.Platform.AgentInputFieldOption do
  @moduledoc """
  Provides struct and type for a AgentInputFieldOption
  """

  @type t :: %__MODULE__{value: String.t()}

  defstruct [:value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [value: :string]
  end
end
