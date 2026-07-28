defmodule Gleanex.Indexing.DatasourceUserDefinition do
  @moduledoc """
  Provides struct and type for a DatasourceUserDefinition
  """

  @type t :: %__MODULE__{
          email: String.t(),
          isActive: boolean | nil,
          name: String.t(),
          userId: String.t() | nil
        }

  defstruct [:email, :isActive, :name, :userId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [email: :string, isActive: :boolean, name: :string, userId: :string]
  end
end
