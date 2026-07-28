defmodule Gleanex.Admin.ListDlpFindingsExportsResponse do
  @moduledoc """
  Provides struct and type for a ListDlpFindingsExportsResponse
  """

  @type t :: %__MODULE__{exports: [Gleanex.Admin.ExportInfo.t()] | nil}

  defstruct [:exports]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [exports: [{Gleanex.Admin.ExportInfo, :t}]]
  end
end
