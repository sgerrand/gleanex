defmodule Gleanex.Client.WorkflowResult do
  @moduledoc """
  Provides struct and type for a WorkflowResult
  """

  @type t :: %__MODULE__{workflow: Gleanex.Client.Workflow.t()}

  defstruct [:workflow]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [workflow: {Gleanex.Client.Workflow, :t}]
  end
end
