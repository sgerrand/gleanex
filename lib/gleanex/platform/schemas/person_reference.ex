defmodule Gleanex.Platform.PersonReference do
  @moduledoc """
  Provides struct and type for a PersonReference
  """

  @type t :: %__MODULE__{id: String.t() | nil, name: String.t()}

  defstruct [:id, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: :string, name: :string]
  end
end
