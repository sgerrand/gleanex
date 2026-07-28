defmodule Gleanex.Admin.ExportInfo do
  @moduledoc """
  Provides struct and type for a ExportInfo
  """

  @type t :: %__MODULE__{
          createdBy: Gleanex.Admin.DlpPerson.t() | nil,
          endTime: String.t() | nil,
          exportId: String.t() | nil,
          exportSize: integer | nil,
          exportType: String.t() | nil,
          fileName: String.t() | nil,
          filter: Gleanex.Admin.DlpFindingFilter.t() | nil,
          issueFilter: Gleanex.Admin.DlpIssueFilter.t() | nil,
          startTime: String.t() | nil,
          status: String.t() | nil
        }

  defstruct [
    :createdBy,
    :endTime,
    :exportId,
    :exportSize,
    :exportType,
    :fileName,
    :filter,
    :issueFilter,
    :startTime,
    :status
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      createdBy: {Gleanex.Admin.DlpPerson, :t},
      endTime: {:string, "iso-date-time"},
      exportId: :string,
      exportSize: {:integer, "int64"},
      exportType: {:enum, ["FINDINGS", "DOCUMENTS", "ISSUES"]},
      fileName: :string,
      filter: {Gleanex.Admin.DlpFindingFilter, :t},
      issueFilter: {Gleanex.Admin.DlpIssueFilter, :t},
      startTime: {:string, "iso-date-time"},
      status: {:enum, ["PENDING", "COMPLETED", "FAILED"]}
    ]
  end
end
