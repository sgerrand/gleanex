defmodule Gleanex.Client.ImportAgentResponse do
  @moduledoc """
  Provides struct and type for a ImportAgentResponse
  """

  @type t :: %__MODULE__{
          status: String.t() | nil,
          workflowResult: Gleanex.Client.WorkflowResult.t() | nil
        }

  defstruct [:status, :workflowResult]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      status: {:enum, ["CREATED", "UPDATED", "DRAFT_PREVIEW"]},
      workflowResult: {Gleanex.Client.WorkflowResult, :t}
    ]
  end
end
