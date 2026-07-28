defmodule Gleanex.Admin.UpdateDlpConfigResponse do
  @moduledoc """
  Provides struct and type for a UpdateDlpConfigResponse
  """

  @type t :: %__MODULE__{reportId: String.t() | nil, result: String.t() | nil}

  defstruct [:reportId, :result]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [reportId: :string, result: {:enum, ["SUCCESS", "FAILURE"]}]
  end
end
