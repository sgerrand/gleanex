defmodule Gleanex.Platform.AgentRequestCreate do
  @moduledoc """
  Provides struct and type for a AgentRequestCreate
  """

  @type t :: %__MODULE__{
          agent_id: String.t(),
          business_justification: String.t() | nil,
          client_id: String.t(),
          desired_limit_amount: String.t() | nil
        }

  defstruct [:agent_id, :business_justification, :client_id, :desired_limit_amount]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agent_id: :string,
      business_justification: :string,
      client_id: :string,
      desired_limit_amount: :string
    ]
  end
end
