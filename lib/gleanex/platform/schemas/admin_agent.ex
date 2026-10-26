defmodule Gleanex.Platform.AdminAgent do
  @moduledoc """
  Provides struct and type for a AdminAgent
  """

  @type t :: %__MODULE__{agent_id: String.t(), display_name: String.t(), is_active: boolean}

  defstruct [:agent_id, :display_name, :is_active]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [agent_id: :string, display_name: :string, is_active: :boolean]
  end
end
