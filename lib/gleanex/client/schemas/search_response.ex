defmodule Gleanex.Client.SearchResponse do
  @moduledoc """
  Provides struct and type for a SearchResponse
  """

  @type t :: %__MODULE__{
          backendTimeMillis: integer | nil,
          cursor: String.t() | nil,
          errorInfo: Gleanex.Client.ErrorInfo.t() | nil,
          experimentIds: [integer] | nil,
          facetResults: [Gleanex.Client.FacetResult.t()] | nil,
          generatedQnaResult: Gleanex.Client.GeneratedQna.t() | nil,
          hasMoreResults: boolean | nil,
          metadata: Gleanex.Client.SearchResponseMetadata.t() | nil,
          requestID: String.t() | nil,
          resultTabIds: [String.t()] | nil,
          resultTabs: [Gleanex.Client.ResultTab.t()] | nil,
          results: [Gleanex.Client.SearchResult.t()] | nil,
          resultsDescription: Gleanex.Client.ResultsDescription.t() | nil,
          rewrittenFacetFilters: [Gleanex.Client.FacetFilter.t()] | nil,
          sessionInfo: Gleanex.Client.SessionInfo.t() | nil,
          structuredResults: [Gleanex.Client.StructuredResult.t()] | nil,
          trackingToken: String.t() | nil
        }

  defstruct [
    :backendTimeMillis,
    :cursor,
    :errorInfo,
    :experimentIds,
    :facetResults,
    :generatedQnaResult,
    :hasMoreResults,
    :metadata,
    :requestID,
    :resultTabIds,
    :resultTabs,
    :results,
    :resultsDescription,
    :rewrittenFacetFilters,
    :sessionInfo,
    :structuredResults,
    :trackingToken
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      backendTimeMillis: {:integer, "int64"},
      cursor: :string,
      errorInfo: {Gleanex.Client.ErrorInfo, :t},
      experimentIds: [integer: "int64"],
      facetResults: [{Gleanex.Client.FacetResult, :t}],
      generatedQnaResult: {Gleanex.Client.GeneratedQna, :t},
      hasMoreResults: :boolean,
      metadata: {Gleanex.Client.SearchResponseMetadata, :t},
      requestID: :string,
      resultTabIds: [:string],
      resultTabs: [{Gleanex.Client.ResultTab, :t}],
      results: [{Gleanex.Client.SearchResult, :t}],
      resultsDescription: {Gleanex.Client.ResultsDescription, :t},
      rewrittenFacetFilters: [{Gleanex.Client.FacetFilter, :t}],
      sessionInfo: {Gleanex.Client.SessionInfo, :t},
      structuredResults: [{Gleanex.Client.StructuredResult, :t}],
      trackingToken: :string
    ]
  end
end
