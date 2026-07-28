defmodule Gleanex.Indexing.UserReferenceDefinition do
  @moduledoc """
  Provides struct and type for a UserReferenceDefinition
  """

  @type t :: %__MODULE__{
          datasourceUserId: String.t() | nil,
          email: String.t() | nil,
          name: String.t() | nil
        }

  defstruct [:datasourceUserId, :email, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [datasourceUserId: :string, email: :string, name: :string]
  end
end
