defmodule Gleanex.Admin.CreateDlpReportRequest do
  @moduledoc """
  Provides struct and type for a CreateDlpReportRequest
  """

  @type t :: %__MODULE__{
          autoHideDocs: boolean | nil,
          config: Gleanex.Admin.DlpConfig.t() | nil,
          frequency: String.t() | nil,
          name: String.t() | nil
        }

  defstruct [:autoHideDocs, :config, :frequency, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      autoHideDocs: :boolean,
      config: {Gleanex.Admin.DlpConfig, :t},
      frequency: {:enum, ["ONCE", "DAILY", "WEEKLY", "CONTINUOUS", "NONE"]},
      name: :string
    ]
  end
end
