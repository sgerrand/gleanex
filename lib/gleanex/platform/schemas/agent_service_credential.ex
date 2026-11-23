defmodule Gleanex.Platform.AgentServiceCredential do
  @moduledoc """
  Provides struct and type for a AgentServiceCredential
  """

  @type t :: %__MODULE__{service_credential_id: String.t()}

  defstruct [:service_credential_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [service_credential_id: :string]
  end
end
