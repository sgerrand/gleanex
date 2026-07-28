defmodule Gleanex.Platform.Message do
  @moduledoc """
  Provides struct and type for a Message
  """

  @type t :: %__MODULE__{content: [Gleanex.Platform.MessageTextBlock.t()], role: String.t()}

  defstruct [:content, :role]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [content: [{Gleanex.Platform.MessageTextBlock, :t}], role: {:enum, ["USER", "GLEAN_AI"]}]
  end
end
