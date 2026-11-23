defmodule Gleanex.Platform.AgentTriggerContent do
  @moduledoc """
  Provides struct and type for a AgentTriggerContent
  """

  @type t :: %__MODULE__{triggers: [Gleanex.Platform.AgentContentTrigger.t()]}

  defstruct [:triggers]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [triggers: [{Gleanex.Platform.AgentContentTrigger, :t}]]
  end
end
