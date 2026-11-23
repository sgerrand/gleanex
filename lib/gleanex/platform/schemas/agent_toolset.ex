defmodule Gleanex.Platform.AgentToolset do
  @moduledoc """
  Provides struct and type for a AgentToolset
  """

  @type t :: %__MODULE__{
          customisation_data: Gleanex.Platform.AgentToolsetCustomisationData.t() | nil,
          selected_tools: [Gleanex.Platform.AgentSelectedTool.t()] | nil,
          tool_provider_id: String.t()
        }

  defstruct [:customisation_data, :selected_tools, :tool_provider_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      customisation_data: {Gleanex.Platform.AgentToolsetCustomisationData, :t},
      selected_tools: [{Gleanex.Platform.AgentSelectedTool, :t}],
      tool_provider_id: :string
    ]
  end
end
