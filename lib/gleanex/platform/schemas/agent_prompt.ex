defmodule Gleanex.Platform.AgentPrompt do
  @moduledoc """
  Provides struct and type for a AgentPrompt
  """

  @type t :: %__MODULE__{display_name: String.t(), template: String.t()}

  defstruct [:display_name, :template]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [display_name: :string, template: :string]
  end
end
