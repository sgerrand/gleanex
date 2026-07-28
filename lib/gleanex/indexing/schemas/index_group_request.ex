defmodule Gleanex.Indexing.IndexGroupRequest do
  @moduledoc """
  Provides struct and type for a IndexGroupRequest
  """

  @type t :: %__MODULE__{
          datasource: String.t(),
          group: Gleanex.Indexing.DatasourceGroupDefinition.t(),
          version: integer | nil
        }

  defstruct [:datasource, :group, :version]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasource: :string,
      group: {Gleanex.Indexing.DatasourceGroupDefinition, :t},
      version: {:integer, "int64"}
    ]
  end
end
