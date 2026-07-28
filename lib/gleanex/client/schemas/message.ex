defmodule Gleanex.Client.Message do
  @moduledoc """
  Provides struct and type for a Message
  """

  @type t :: %__MODULE__{
          content: [Gleanex.Client.MessageTextBlock.t()] | nil,
          role: String.t() | nil
        }

  defstruct [:content, :role]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [content: [{Gleanex.Client.MessageTextBlock, :t}], role: :string]
  end
end
