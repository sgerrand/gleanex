defmodule Gleanex.Indexing.DeleteUserRequest do
  @moduledoc """
  Provides struct and type for a DeleteUserRequest
  """

  @type t :: %__MODULE__{datasource: String.t(), email: String.t(), version: integer | nil}

  defstruct [:datasource, :email, :version]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [datasource: :string, email: :string, version: {:integer, "int64"}]
  end
end
