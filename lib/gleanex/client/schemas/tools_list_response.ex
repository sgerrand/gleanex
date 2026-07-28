defmodule Gleanex.Client.ToolsListResponse do
  @moduledoc """
  Provides struct and type for a ToolsListResponse
  """

  @type t :: %__MODULE__{tools: [Gleanex.Client.Tool.t()] | nil}

  defstruct [:tools]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [tools: [{Gleanex.Client.Tool, :t}]]
  end
end
