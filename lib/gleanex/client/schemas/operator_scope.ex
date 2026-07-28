defmodule Gleanex.Client.OperatorScope do
  @moduledoc """
  Provides struct and type for a OperatorScope
  """

  @type t :: %__MODULE__{datasource: String.t() | nil, docType: String.t() | nil}

  defstruct [:datasource, :docType]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [datasource: :string, docType: :string]
  end
end
