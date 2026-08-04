defmodule Gleanex.Client.ToolDefinition do
  @moduledoc """
  Provides struct and type for a ToolDefinition
  """

  @type t :: %__MODULE__{
          annotations: Gleanex.Client.ToolAnnotations.t() | nil,
          description: String.t() | nil,
          displayName: String.t() | nil,
          inputSchema: map | nil,
          name: String.t(),
          serverId: String.t()
        }

  defstruct [:annotations, :description, :displayName, :inputSchema, :name, :serverId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      annotations: {Gleanex.Client.ToolAnnotations, :t},
      description: :string,
      displayName: :string,
      inputSchema: :map,
      name: :string,
      serverId: :string
    ]
  end
end
