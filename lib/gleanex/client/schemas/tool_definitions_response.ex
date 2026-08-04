defmodule Gleanex.Client.ToolDefinitionsResponse do
  @moduledoc """
  Provides struct and type for a ToolDefinitionsResponse
  """

  @type t :: %__MODULE__{notFound: [String.t()] | nil, tools: [Gleanex.Client.ToolDefinition.t()]}

  defstruct [:notFound, :tools]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [notFound: [:string], tools: [{Gleanex.Client.ToolDefinition, :t}]]
  end
end
