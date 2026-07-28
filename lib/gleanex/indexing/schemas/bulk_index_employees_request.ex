defmodule Gleanex.Indexing.BulkIndexEmployeesRequest do
  @moduledoc """
  Provides struct and type for a BulkIndexEmployeesRequest
  """

  @type t :: %__MODULE__{
          disableStaleDataDeletionCheck: boolean | nil,
          employees: [Gleanex.Indexing.EmployeeInfoDefinition.t()] | nil,
          forceRestartUpload: boolean | nil,
          isFirstPage: boolean | nil,
          isLastPage: boolean | nil,
          uploadId: String.t() | nil
        }

  defstruct [
    :disableStaleDataDeletionCheck,
    :employees,
    :forceRestartUpload,
    :isFirstPage,
    :isLastPage,
    :uploadId
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      disableStaleDataDeletionCheck: :boolean,
      employees: [{Gleanex.Indexing.EmployeeInfoDefinition, :t}],
      forceRestartUpload: :boolean,
      isFirstPage: :boolean,
      isLastPage: :boolean,
      uploadId: :string
    ]
  end
end
