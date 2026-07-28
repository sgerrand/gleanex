defmodule Gleanex.Indexing.BulkIndexTeamsRequest do
  @moduledoc """
  Provides struct and type for a BulkIndexTeamsRequest
  """

  @type t :: %__MODULE__{
          forceRestartUpload: boolean | nil,
          isFirstPage: boolean | nil,
          isLastPage: boolean | nil,
          teams: [Gleanex.Indexing.TeamInfoDefinition.t()] | nil,
          uploadId: String.t() | nil
        }

  defstruct [:forceRestartUpload, :isFirstPage, :isLastPage, :teams, :uploadId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      forceRestartUpload: :boolean,
      isFirstPage: :boolean,
      isLastPage: :boolean,
      teams: [{Gleanex.Indexing.TeamInfoDefinition, :t}],
      uploadId: :string
    ]
  end
end
