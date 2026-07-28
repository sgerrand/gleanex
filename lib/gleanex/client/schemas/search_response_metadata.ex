defmodule Gleanex.Client.SearchResponseMetadata do
  @moduledoc """
  Provides struct and type for a SearchResponseMetadata
  """

  @type t :: %__MODULE__{
          additionalQuerySuggestions: Gleanex.Client.QuerySuggestionList.t() | nil,
          isNoQuotesSuggestion: boolean | nil,
          modifiedQueryWasUsed: boolean | nil,
          negatedTerms: [String.t()] | nil,
          originalQuery: String.t() | nil,
          originalQueryHadNoResults: boolean | nil,
          querySuggestion: Gleanex.Client.QuerySuggestion.t() | nil,
          rewrittenQuery: String.t() | nil,
          searchWarning: Gleanex.Client.SearchWarning.t() | nil,
          searchedQuery: String.t() | nil,
          searchedQueryRanges: [Gleanex.Client.TextRange.t()] | nil,
          searchedQueryWithoutNegation: String.t() | nil,
          triggeredExpertDetection: boolean | nil
        }

  defstruct [
    :additionalQuerySuggestions,
    :isNoQuotesSuggestion,
    :modifiedQueryWasUsed,
    :negatedTerms,
    :originalQuery,
    :originalQueryHadNoResults,
    :querySuggestion,
    :rewrittenQuery,
    :searchWarning,
    :searchedQuery,
    :searchedQueryRanges,
    :searchedQueryWithoutNegation,
    :triggeredExpertDetection
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      additionalQuerySuggestions: {Gleanex.Client.QuerySuggestionList, :t},
      isNoQuotesSuggestion: :boolean,
      modifiedQueryWasUsed: :boolean,
      negatedTerms: [:string],
      originalQuery: :string,
      originalQueryHadNoResults: :boolean,
      querySuggestion: {Gleanex.Client.QuerySuggestion, :t},
      rewrittenQuery: :string,
      searchWarning: {Gleanex.Client.SearchWarning, :t},
      searchedQuery: :string,
      searchedQueryRanges: [{Gleanex.Client.TextRange, :t}],
      searchedQueryWithoutNegation: :string,
      triggeredExpertDetection: :boolean
    ]
  end
end
