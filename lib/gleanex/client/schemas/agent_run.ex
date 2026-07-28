defmodule Gleanex.Client.AgentRun do
  @moduledoc """
  Provides struct and type for a AgentRun
  """

  @type t :: %__MODULE__{
          agent_id: String.t() | nil,
          input: map | nil,
          messages: [Gleanex.Client.Message.t()] | nil,
          metadata: map | nil,
          status: String.t() | nil
        }

  defstruct [:agent_id, :input, :messages, :metadata, :status]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agent_id: :string,
      input: :map,
      messages: [{Gleanex.Client.Message, :t}],
      metadata: :map,
      status: {:enum, ["error", "success"]}
    ]
  end
end
