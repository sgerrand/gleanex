defmodule Gleanex.Client.AgentRunCreate do
  @moduledoc """
  Provides struct and type for a AgentRunCreate
  """

  @type t :: %__MODULE__{
          agent_id: String.t(),
          input: map | nil,
          messages: [Gleanex.Client.Message.t()] | nil,
          metadata: map | nil
        }

  defstruct [:agent_id, :input, :messages, :metadata]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [agent_id: :string, input: :map, messages: [{Gleanex.Client.Message, :t}], metadata: :map]
  end
end
