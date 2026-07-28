defmodule Gleanex.Indexing.DebugDatasourceStatusResponseDocumentsCounts do
  @moduledoc """
  Provides struct and type for a DebugDatasourceStatusResponseDocumentsCounts
  """

  @type t :: %__MODULE__{
          indexed: [Gleanex.Indexing.DatasourceObjectTypeDocumentCountEntry.t()] | nil,
          uploaded: [Gleanex.Indexing.DatasourceObjectTypeDocumentCountEntry.t()] | nil
        }

  defstruct [:indexed, :uploaded]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      indexed: [{Gleanex.Indexing.DatasourceObjectTypeDocumentCountEntry, :t}],
      uploaded: [{Gleanex.Indexing.DatasourceObjectTypeDocumentCountEntry, :t}]
    ]
  end
end
