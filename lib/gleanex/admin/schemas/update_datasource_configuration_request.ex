defmodule Gleanex.Admin.UpdateDatasourceConfigurationRequest do
  @moduledoc """
  Provides struct and type for a UpdateDatasourceConfigurationRequest
  """

  @type t :: %__MODULE__{configuration: Gleanex.Admin.DatasourceInstanceConfiguration.t()}

  defstruct [:configuration]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [configuration: {Gleanex.Admin.DatasourceInstanceConfiguration, :t}]
  end
end
