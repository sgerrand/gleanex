defmodule Gleanex.Platform.AgentRunApprovalDecision do
  @moduledoc """
  Provides struct and type for a AgentRunApprovalDecision
  """

  @type t :: %__MODULE__{decision: String.t(), interaction_id: String.t()}

  defstruct [:decision, :interaction_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [decision: {:enum, ["APPROVE", "REJECT"]}, interaction_id: :string]
  end
end
