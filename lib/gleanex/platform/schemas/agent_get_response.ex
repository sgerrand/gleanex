defmodule Gleanex.Platform.AgentGetResponse do
  @moduledoc """
  Provides struct and type for a AgentGetResponse
  """

  @type t :: %__MODULE__{agent: Gleanex.Platform.Agent.t(), request_id: String.t()}

  defstruct [:agent, :request_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [agent: {Gleanex.Platform.Agent, :t}, request_id: :string]
  end
end
