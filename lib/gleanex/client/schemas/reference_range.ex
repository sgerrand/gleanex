defmodule Gleanex.Client.ReferenceRange do
  @moduledoc """
  Provides struct and type for a ReferenceRange
  """

  @type t :: %__MODULE__{
          snippets: [Gleanex.Client.SearchResultSnippet.t()] | nil,
          textRange: Gleanex.Client.TextRange.t() | nil
        }

  defstruct [:snippets, :textRange]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      snippets: [{Gleanex.Client.SearchResultSnippet, :t}],
      textRange: {Gleanex.Client.TextRange, :t}
    ]
  end
end
