defmodule Gleanex.Indexing.DebugDatasourceStatusResponse do
  @moduledoc """
  Provides struct and type for a DebugDatasourceStatusResponse
  """

  @type t :: %__MODULE__{
          datasourceVisibility: String.t() | nil,
          documents: Gleanex.Indexing.DebugDatasourceStatusResponseDocuments.t() | nil,
          identity: Gleanex.Indexing.DebugDatasourceStatusResponseIdentity.t() | nil
        }

  defstruct [:datasourceVisibility, :documents, :identity]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasourceVisibility: {:enum, ["ENABLED_FOR_ALL", "ENABLED_FOR_TEST_GROUP", "NOT_ENABLED"]},
      documents: {Gleanex.Indexing.DebugDatasourceStatusResponseDocuments, :t},
      identity: {Gleanex.Indexing.DebugDatasourceStatusResponseIdentity, :t}
    ]
  end
end
