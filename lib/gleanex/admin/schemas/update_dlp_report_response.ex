defmodule Gleanex.Admin.UpdateDlpReportResponse do
  @moduledoc """
  Provides struct and type for a UpdateDlpReportResponse
  """

  @type t :: %__MODULE__{result: String.t() | nil}

  defstruct [:result]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [result: {:enum, ["SUCCESS", "FAILURE"]}]
  end
end
