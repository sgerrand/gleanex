defmodule Gleanex.Platform.AgentSelectedTool do
  @moduledoc """
  Provides struct and type for a AgentSelectedTool
  """

  @type t :: %__MODULE__{display_name: String.t()}

  defstruct [:display_name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [display_name: :string]
  end
end
