defmodule Gleanex.Client.CodeLine do
  @moduledoc """
  Provides struct and type for a CodeLine
  """

  @type t :: %__MODULE__{
          content: String.t() | nil,
          lineNumber: integer | nil,
          ranges: [Gleanex.Client.TextRange.t()] | nil
        }

  defstruct [:content, :lineNumber, :ranges]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [content: :string, lineNumber: :integer, ranges: [{Gleanex.Client.TextRange, :t}]]
  end
end
