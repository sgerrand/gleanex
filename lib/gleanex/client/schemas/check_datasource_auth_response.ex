defmodule Gleanex.Client.CheckDatasourceAuthResponse do
  @moduledoc """
  Provides struct and type for a CheckDatasourceAuthResponse
  """

  @type t :: %__MODULE__{
          unauthorizedDatasourceInstances: [Gleanex.Client.UnauthorizedDatasourceInstance.t()]
        }

  defstruct [:unauthorizedDatasourceInstances]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [unauthorizedDatasourceInstances: [{Gleanex.Client.UnauthorizedDatasourceInstance, :t}]]
  end
end
