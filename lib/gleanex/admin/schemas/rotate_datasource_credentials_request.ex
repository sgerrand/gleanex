defmodule Gleanex.Admin.RotateDatasourceCredentialsRequest do
  @moduledoc """
  Provides struct and type for a RotateDatasourceCredentialsRequest
  """

  @type t :: %__MODULE__{credentials: Gleanex.Admin.DatasourceInstanceConfiguration.t()}

  defstruct [:credentials]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [credentials: {Gleanex.Admin.DatasourceInstanceConfiguration, :t}]
  end
end
