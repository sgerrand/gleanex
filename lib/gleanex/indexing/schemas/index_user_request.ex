defmodule Gleanex.Indexing.IndexUserRequest do
  @moduledoc """
  Provides struct and type for a IndexUserRequest
  """

  @type t :: %__MODULE__{
          datasource: String.t(),
          user: Gleanex.Indexing.DatasourceUserDefinition.t(),
          version: integer | nil
        }

  defstruct [:datasource, :user, :version]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasource: :string,
      user: {Gleanex.Indexing.DatasourceUserDefinition, :t},
      version: {:integer, "int64"}
    ]
  end
end
