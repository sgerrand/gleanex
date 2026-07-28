defmodule Gleanex.Admin.UpdateDlpConfigRequest do
  @moduledoc """
  Provides struct and type for a UpdateDlpConfigRequest
  """

  @type t :: %__MODULE__{config: Gleanex.Admin.DlpConfig.t() | nil, frequency: String.t() | nil}

  defstruct [:config, :frequency]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [config: {Gleanex.Admin.DlpConfig, :t}, frequency: :string]
  end
end
