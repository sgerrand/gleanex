defmodule Gleanex.Admin.DlpReport do
  @moduledoc """
  Provides struct and type for a DlpReport
  """

  @type t :: %__MODULE__{
          autoHideDocs: boolean | nil,
          config: Gleanex.Admin.DlpConfig.t() | nil,
          createdAt: String.t() | nil,
          createdBy: Gleanex.Admin.DlpPerson.t() | nil,
          frequency: String.t() | nil,
          id: String.t() | nil,
          lastScanStartTime: String.t() | nil,
          lastScanStatus: String.t() | nil,
          lastUpdatedAt: String.t() | nil,
          name: String.t() | nil,
          status: String.t() | nil,
          updatedBy: Gleanex.Admin.DlpPerson.t() | nil
        }

  defstruct [
    :autoHideDocs,
    :config,
    :createdAt,
    :createdBy,
    :frequency,
    :id,
    :lastScanStartTime,
    :lastScanStatus,
    :lastUpdatedAt,
    :name,
    :status,
    :updatedBy
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      autoHideDocs: :boolean,
      config: {Gleanex.Admin.DlpConfig, :t},
      createdAt: {:string, "iso-date-time"},
      createdBy: {Gleanex.Admin.DlpPerson, :t},
      frequency: {:enum, ["ONCE", "DAILY", "WEEKLY", "CONTINUOUS", "NONE"]},
      id: :string,
      lastScanStartTime: {:string, "iso-date-time"},
      lastScanStatus:
        {:enum, ["PENDING", "SUCCESS", "FAILURE", "CANCELLED", "CANCELLING", "ACTIVE"]},
      lastUpdatedAt: {:string, "iso-date-time"},
      name: :string,
      status: {:enum, ["ACTIVE", "INACTIVE", "CANCELLED", "NONE"]},
      updatedBy: {Gleanex.Admin.DlpPerson, :t}
    ]
  end
end
