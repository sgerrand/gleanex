defmodule Gleanex.Platform.ChatOutputMessage do
  @moduledoc """
  Provides struct and type for a ChatOutputMessage
  """

  @type t :: %__MODULE__{
          content: [Gleanex.Platform.ChatOutputTextContent.t()],
          role: String.t(),
          type: String.t()
        }

  defstruct [:content, :role, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      content: [{Gleanex.Platform.ChatOutputTextContent, :t}],
      role: {:const, "ASSISTANT"},
      type: {:const, "MESSAGE"}
    ]
  end
end
