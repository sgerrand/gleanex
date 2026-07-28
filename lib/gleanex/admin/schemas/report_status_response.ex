defmodule Gleanex.Admin.ReportStatusResponse do
  @moduledoc """
  Provides struct and type for a ReportStatusResponse
  """

  @type t :: %__MODULE__{startTime: String.t() | nil, status: String.t() | nil}

  defstruct [:startTime, :status]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      startTime: {:string, "iso-date-time"},
      status: {:enum, ["PENDING", "SUCCESS", "FAILURE", "CANCELLED", "CANCELLING", "ACTIVE"]}
    ]
  end
end
