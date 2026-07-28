defmodule Gleanex.Client.SearchResultSnippet do
  @moduledoc """
  Provides struct and type for a SearchResultSnippet
  """

  @type t :: %__MODULE__{
          mimeType: String.t() | nil,
          ranges: [Gleanex.Client.TextRange.t()] | nil,
          snippet: String.t() | nil,
          snippetTextOrdering: integer | nil,
          text: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [:mimeType, :ranges, :snippet, :snippetTextOrdering, :text, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      mimeType: :string,
      ranges: [{Gleanex.Client.TextRange, :t}],
      snippet: :string,
      snippetTextOrdering: :integer,
      text: :string,
      url: :string
    ]
  end
end
