defmodule Gleanex.Client.UnauthorizedDatasourceInstance do
  @moduledoc """
  Provides struct and type for a UnauthorizedDatasourceInstance
  """

  @type t :: %__MODULE__{
          authStatus: String.t() | nil,
          authUrlRelativePath: String.t() | nil,
          datasourceInstance: String.t() | nil,
          displayName: String.t() | nil
        }

  defstruct [:authStatus, :authUrlRelativePath, :datasourceInstance, :displayName]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      authStatus:
        {:enum, ["DISABLED", "AWAITING_AUTH", "AUTHORIZED", "STALE_OAUTH", "SEG_MIGRATION"]},
      authUrlRelativePath: :string,
      datasourceInstance: :string,
      displayName: :string
    ]
  end
end
