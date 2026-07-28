defmodule Gleanex.Admin.CreateDlpReportResponse do
  @moduledoc """
  Provides struct and type for a CreateDlpReportResponse
  """

  @type t :: %__MODULE__{report: Gleanex.Admin.DlpReport.t() | nil}

  defstruct [:report]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [report: {Gleanex.Admin.DlpReport, :t}]
  end
end
