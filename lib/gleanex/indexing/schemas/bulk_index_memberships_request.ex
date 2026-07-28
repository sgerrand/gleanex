defmodule Gleanex.Indexing.BulkIndexMembershipsRequest do
  @moduledoc """
  Provides struct and type for a BulkIndexMembershipsRequest
  """

  @type t :: %__MODULE__{
          datasource: String.t(),
          forceRestartUpload: boolean | nil,
          group: String.t() | nil,
          isFirstPage: boolean | nil,
          isLastPage: boolean | nil,
          memberships: [Gleanex.Indexing.DatasourceBulkMembershipDefinition.t()],
          uploadId: String.t()
        }

  defstruct [
    :datasource,
    :forceRestartUpload,
    :group,
    :isFirstPage,
    :isLastPage,
    :memberships,
    :uploadId
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasource: :string,
      forceRestartUpload: :boolean,
      group: :string,
      isFirstPage: :boolean,
      isLastPage: :boolean,
      memberships: [{Gleanex.Indexing.DatasourceBulkMembershipDefinition, :t}],
      uploadId: :string
    ]
  end
end
