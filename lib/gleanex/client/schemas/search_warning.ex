defmodule Gleanex.Client.SearchWarning do
  @moduledoc """
  Provides struct and type for a SearchWarning
  """

  @type t :: %__MODULE__{
          ignoredTerms: [String.t()] | nil,
          lastUsedTerm: String.t() | nil,
          quotesIgnoredQuery: String.t() | nil,
          warningType: String.t()
        }

  defstruct [:ignoredTerms, :lastUsedTerm, :quotesIgnoredQuery, :warningType]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      ignoredTerms: [:string],
      lastUsedTerm: :string,
      quotesIgnoredQuery: :string,
      warningType:
        {:enum,
         [
           "LONG_QUERY",
           "QUOTED_PUNCTUATION",
           "PUNCTUATION_ONLY",
           "COPYPASTED_QUOTES",
           "INVALID_OPERATOR",
           "MAYBE_INVALID_FACET_QUERY",
           "TOO_MANY_DATASOURCE_GROUPS"
         ]}
    ]
  end
end
