defmodule Gleanex.Indexing.BulkIndexGroupsRequest do
  @moduledoc """
  Provides struct and type for a BulkIndexGroupsRequest
  """

  @type t :: %__MODULE__{
          datasource: String.t(),
          disableStaleDataDeletionCheck: boolean | nil,
          forceRestartUpload: boolean | nil,
          groups: [Gleanex.Indexing.DatasourceGroupDefinition.t()],
          isFirstPage: boolean | nil,
          isLastPage: boolean | nil,
          uploadId: String.t()
        }

  defstruct [
    :datasource,
    :disableStaleDataDeletionCheck,
    :forceRestartUpload,
    :groups,
    :isFirstPage,
    :isLastPage,
    :uploadId
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasource: :string,
      disableStaleDataDeletionCheck: :boolean,
      forceRestartUpload: :boolean,
      groups: [{Gleanex.Indexing.DatasourceGroupDefinition, :t}],
      isFirstPage: :boolean,
      isLastPage: :boolean,
      uploadId: :string
    ]
  end
end
