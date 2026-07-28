defmodule Gleanex.Client.PersonObject do
  @moduledoc """
  Provides struct and type for a PersonObject
  """

  @type t :: %__MODULE__{name: String.t(), obfuscatedId: String.t()}

  defstruct [:name, :obfuscatedId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [name: :string, obfuscatedId: :string]
  end
end
