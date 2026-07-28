defmodule Gleanex.Indexing.EntityRelationship do
  @moduledoc """
  Provides struct and type for a EntityRelationship
  """

  @type t :: %__MODULE__{email: String.t(), name: String.t()}

  defstruct [:email, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [email: :string, name: :string]
  end
end
