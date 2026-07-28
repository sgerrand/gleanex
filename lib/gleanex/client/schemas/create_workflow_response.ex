defmodule Gleanex.Client.CreateWorkflowResponse do
  @moduledoc """
  Provides struct and type for a CreateWorkflowResponse
  """

  @type t :: %__MODULE__{workflow: Gleanex.Client.Workflow.t() | nil}

  defstruct [:workflow]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [workflow: {Gleanex.Client.Workflow, :t}]
  end
end
