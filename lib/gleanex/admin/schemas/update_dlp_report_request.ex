defmodule Gleanex.Admin.UpdateDlpReportRequest do
  @moduledoc """
  Provides struct and type for a UpdateDlpReportRequest
  """

  @type t :: %__MODULE__{
          autoHideDocs: boolean | nil,
          config: Gleanex.Admin.DlpConfig.t() | nil,
          frequency: String.t() | nil,
          reportName: String.t() | nil,
          status: String.t() | nil
        }

  defstruct [:autoHideDocs, :config, :frequency, :reportName, :status]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      autoHideDocs: :boolean,
      config: {Gleanex.Admin.DlpConfig, :t},
      frequency: {:enum, ["ONCE", "DAILY", "WEEKLY", "CONTINUOUS", "NONE"]},
      reportName: :string,
      status: {:enum, ["ACTIVE", "INACTIVE", "CANCELLED", "NONE"]}
    ]
  end
end
