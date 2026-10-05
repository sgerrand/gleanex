defmodule Gleanex.Platform.AgentRunCancellationRequest do
  @moduledoc """
  Provides struct and type for a AgentRunCancellationRequest
  """

  @type t :: %__MODULE__{run_id: String.t()}

  defstruct [:run_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [run_id: :string]
  end
end
