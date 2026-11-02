defmodule Gleanex.Platform.AgentRunResponse do
  @moduledoc """
  Provides struct and type for a AgentRunResponse
  """

  @type t :: %__MODULE__{request_id: String.t(), run: Gleanex.Platform.DurableAgentRun.t()}

  defstruct [:request_id, :run]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [request_id: :string, run: {Gleanex.Platform.DurableAgentRun, :t}]
  end
end
