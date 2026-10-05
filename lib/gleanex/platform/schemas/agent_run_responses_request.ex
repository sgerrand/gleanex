defmodule Gleanex.Platform.AgentRunResponsesRequest do
  @moduledoc """
  Provides struct and type for a AgentRunResponsesRequest
  """

  @type t :: %__MODULE__{
          responses: [Gleanex.Platform.AgentRunApprovalDecision.t()],
          run_id: String.t()
        }

  defstruct [:responses, :run_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [responses: [{Gleanex.Platform.AgentRunApprovalDecision, :t}], run_id: :string]
  end
end
