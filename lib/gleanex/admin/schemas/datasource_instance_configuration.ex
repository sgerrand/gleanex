defmodule Gleanex.Admin.DatasourceInstanceConfiguration do
  @moduledoc """
  Provides struct and type for a DatasourceInstanceConfiguration
  """

  @type t :: %__MODULE__{values: map}

  defstruct [:values]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [values: :map]
  end
end
