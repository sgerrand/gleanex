defmodule Gleanex.Client.AgentConfig do
  @moduledoc """
  Provides struct and type for a AgentConfig
  """

  @type t :: %__MODULE__{
          agent: String.t() | nil,
          mode: String.t() | nil,
          toolSets: Gleanex.Client.ToolSets.t() | nil,
          useImageGeneration: boolean | nil
        }

  defstruct [:agent, :mode, :toolSets, :useImageGeneration]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agent: {:enum, ["DEFAULT", "GPT", "UNIVERSAL", "FAST", "ADVANCED", "AUTO"]},
      mode: {:enum, ["DEFAULT", "QUICK"]},
      toolSets: {Gleanex.Client.ToolSets, :t},
      useImageGeneration: :boolean
    ]
  end
end
