defmodule Gleanex.Admin.ListDlpReportsResponse do
  @moduledoc """
  Provides struct and type for a ListDlpReportsResponse
  """

  @type t :: %__MODULE__{reports: [Gleanex.Admin.DlpReport.t()] | nil}

  defstruct [:reports]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [reports: [{Gleanex.Admin.DlpReport, :t}]]
  end
end
