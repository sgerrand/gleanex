defmodule Gleanex.Admin.DlpIssueFilter do
  @moduledoc """
  Provides struct and type for a DlpIssueFilter
  """

  @type t :: %__MODULE__{
          assigneeId: String.t() | nil,
          assigneeIds: [String.t()] | nil,
          datasource: String.t() | nil,
          datasources: [String.t()] | nil,
          docId: String.t() | nil,
          infoType: String.t() | nil,
          infoTypes: [String.t()] | nil,
          regexId: String.t() | nil,
          regexIds: [String.t()] | nil,
          reportIds: [String.t()] | nil,
          searchText: String.t() | nil,
          severities: [String.t()] | nil,
          statuses: [String.t()] | nil,
          timeRange: Gleanex.Admin.TimeRangeFilter.t() | nil,
          visibility: String.t() | nil
        }

  defstruct [
    :assigneeId,
    :assigneeIds,
    :datasource,
    :datasources,
    :docId,
    :infoType,
    :infoTypes,
    :regexId,
    :regexIds,
    :reportIds,
    :searchText,
    :severities,
    :statuses,
    :timeRange,
    :visibility
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      assigneeId: :string,
      assigneeIds: [:string],
      datasource: :string,
      datasources: [:string],
      docId: :string,
      infoType: :string,
      infoTypes: [:string],
      regexId: :string,
      regexIds: [:string],
      reportIds: [:string],
      searchText: :string,
      severities: [enum: ["UNSPECIFIED", "LOW", "MEDIUM", "HIGH", "FALSE_POSITIVE"]],
      statuses: [enum: ["OPEN", "CLOSED", "IN_PROGRESS", "RESOLVED"]],
      timeRange: {Gleanex.Admin.TimeRangeFilter, :t},
      visibility: :string
    ]
  end
end
