defmodule Gleanex.Admin.DlpFindingFilter do
  @moduledoc """
  Provides struct and type for a DlpFindingFilter
  """

  @type t :: %__MODULE__{
          archived: boolean | nil,
          datasource: String.t() | nil,
          documentIds: [String.t()] | nil,
          documentSeverity: [String.t()] | nil,
          infoType: String.t() | nil,
          regexId: String.t() | nil,
          reportId: String.t() | nil,
          severity: String.t() | nil,
          statuses: [String.t()] | nil,
          timeRange: Gleanex.Admin.TimeRangeFilter.t() | nil,
          visibility: String.t() | nil
        }

  defstruct [
    :archived,
    :datasource,
    :documentIds,
    :documentSeverity,
    :infoType,
    :regexId,
    :reportId,
    :severity,
    :statuses,
    :timeRange,
    :visibility
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      archived: :boolean,
      datasource: :string,
      documentIds: [:string],
      documentSeverity: [enum: ["UNSPECIFIED", "LOW", "MEDIUM", "HIGH", "FALSE_POSITIVE"]],
      infoType: :string,
      regexId: :string,
      reportId: :string,
      severity: {:enum, ["UNSPECIFIED", "LOW", "MEDIUM", "HIGH", "FALSE_POSITIVE"]},
      statuses: [enum: ["OPEN", "CLOSED", "IN_PROGRESS", "RESOLVED"]],
      timeRange: {Gleanex.Admin.TimeRangeFilter, :t},
      visibility: :string
    ]
  end
end
