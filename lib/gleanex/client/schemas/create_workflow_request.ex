defmodule Gleanex.Client.CreateWorkflowRequest do
  @moduledoc """
  Provides struct and type for a CreateWorkflowRequest
  """

  @type t :: %__MODULE__{parentWorkflowId: String.t() | nil, transient: boolean | nil}

  defstruct [:parentWorkflowId, :transient]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [parentWorkflowId: :string, transient: :boolean]
  end
end
