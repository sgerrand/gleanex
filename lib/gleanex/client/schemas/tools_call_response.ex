defmodule Gleanex.Client.ToolsCallResponse do
  @moduledoc """
  Provides struct and type for a ToolsCallResponse
  """

  @type t :: %__MODULE__{error: String.t() | nil, rawResponse: map | nil}

  defstruct [:error, :rawResponse]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [error: :string, rawResponse: :map]
  end
end
