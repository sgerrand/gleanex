defmodule Gleanex.Client.Agent do
  @moduledoc """
  Provides struct and type for a Agent
  """

  @type t :: %__MODULE__{
          agent_id: String.t(),
          capabilities: Gleanex.Client.AgentCapabilities.t(),
          description: String.t() | nil,
          metadata: map | nil,
          name: String.t()
        }

  defstruct [:agent_id, :capabilities, :description, :metadata, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agent_id: :string,
      capabilities: {Gleanex.Client.AgentCapabilities, :t},
      description: :string,
      metadata: :map,
      name: :string
    ]
  end
end
