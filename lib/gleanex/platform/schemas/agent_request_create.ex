defmodule Gleanex.Platform.AgentRequestCreate do
  @moduledoc """
  Provides struct and type for a AgentRequestCreate
  """

  @type t :: %__MODULE__{
          agent_id: String.t(),
          business_justification: String.t() | nil,
          client_id: String.t()
        }

  defstruct [:agent_id, :business_justification, :client_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [agent_id: :string, business_justification: :string, client_id: :string]
  end
end
