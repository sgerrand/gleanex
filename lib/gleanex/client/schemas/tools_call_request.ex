defmodule Gleanex.Client.ToolsCallRequest do
  @moduledoc """
  Provides struct and type for a ToolsCallRequest
  """

  @type t :: %__MODULE__{name: String.t(), parameters: map}

  defstruct [:name, :parameters]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [name: :string, parameters: :map]
  end
end
