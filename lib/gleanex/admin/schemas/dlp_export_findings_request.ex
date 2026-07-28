defmodule Gleanex.Admin.DlpExportFindingsRequest do
  @moduledoc """
  Provides struct and type for a DlpExportFindingsRequest
  """

  @type t :: %__MODULE__{
          exportType: String.t() | nil,
          fieldScope: String.t() | nil,
          fieldsToExclude: [String.t()] | nil,
          fileName: String.t() | nil,
          filter: Gleanex.Admin.DlpFindingFilter.t() | nil,
          issueFilter: Gleanex.Admin.DlpIssueFilter.t() | nil
        }

  defstruct [:exportType, :fieldScope, :fieldsToExclude, :fileName, :filter, :issueFilter]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      exportType: {:enum, ["FINDINGS", "DOCUMENTS", "ISSUES"]},
      fieldScope: {:enum, ["ALL", "EXCLUDE_SENSITIVE", "CUSTOM"]},
      fieldsToExclude: [:string],
      fileName: :string,
      filter: {Gleanex.Admin.DlpFindingFilter, :t},
      issueFilter: {Gleanex.Admin.DlpIssueFilter, :t}
    ]
  end
end
