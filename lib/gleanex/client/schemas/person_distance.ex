defmodule Gleanex.Client.PersonDistance do
  @moduledoc """
  Provides struct and type for a PersonDistance
  """

  @type t :: %__MODULE__{distance: number, name: String.t(), obfuscatedId: String.t()}

  defstruct [:distance, :name, :obfuscatedId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [distance: {:number, "float"}, name: :string, obfuscatedId: :string]
  end
end
