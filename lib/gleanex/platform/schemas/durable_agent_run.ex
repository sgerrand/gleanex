defmodule Gleanex.Platform.DurableAgentRun do
  @moduledoc """
  Provides struct and type for a DurableAgentRun
  """

  @type t :: %__MODULE__{
          agent_id: String.t(),
          created_at: DateTime.t(),
          error: Gleanex.Platform.AgentRunError.t() | nil,
          expires_at: DateTime.t() | nil,
          output: map | nil,
          pending_interactions: [Gleanex.Platform.AgentRunToolApproval.t()],
          run_id: String.t(),
          state: String.t(),
          updated_at: DateTime.t()
        }

  defstruct [
    :agent_id,
    :created_at,
    :error,
    :expires_at,
    :output,
    :pending_interactions,
    :run_id,
    :state,
    :updated_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agent_id: :string,
      created_at: {:string, "date-time"},
      error: {Gleanex.Platform.AgentRunError, :t},
      expires_at: {:string, "date-time"},
      output: :map,
      pending_interactions: [{Gleanex.Platform.AgentRunToolApproval, :t}],
      run_id: :string,
      state:
        {:enum,
         [
           "QUEUED",
           "RUNNING",
           "REQUIRES_INPUT",
           "SUCCEEDED",
           "FAILED",
           "CANCELLING",
           "CANCELLED",
           "EXPIRED"
         ]},
      updated_at: {:string, "date-time"}
    ]
  end
end
