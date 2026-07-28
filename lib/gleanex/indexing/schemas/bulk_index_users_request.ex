defmodule Gleanex.Indexing.BulkIndexUsersRequest do
  @moduledoc """
  Provides struct and type for a BulkIndexUsersRequest
  """

  @type t :: %__MODULE__{
          datasource: String.t(),
          disableStaleDataDeletionCheck: boolean | nil,
          forceRestartUpload: boolean | nil,
          isFirstPage: boolean | nil,
          isLastPage: boolean | nil,
          uploadId: String.t(),
          users: [Gleanex.Indexing.DatasourceUserDefinition.t()]
        }

  defstruct [
    :datasource,
    :disableStaleDataDeletionCheck,
    :forceRestartUpload,
    :isFirstPage,
    :isLastPage,
    :uploadId,
    :users
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasource: :string,
      disableStaleDataDeletionCheck: :boolean,
      forceRestartUpload: :boolean,
      isFirstPage: :boolean,
      isLastPage: :boolean,
      uploadId: :string,
      users: [{Gleanex.Indexing.DatasourceUserDefinition, :t}]
    ]
  end
end
