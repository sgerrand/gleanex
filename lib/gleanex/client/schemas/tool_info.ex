defmodule Gleanex.Client.ToolInfo do
  @moduledoc """
  Provides struct and type for a ToolInfo
  """

  @type t :: %__MODULE__{metadata: Gleanex.Client.ToolMetadata.t() | nil, parameters: map | nil}

  defstruct [:metadata, :parameters]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [metadata: {Gleanex.Client.ToolMetadata, :t}, parameters: :map]
  end
end
