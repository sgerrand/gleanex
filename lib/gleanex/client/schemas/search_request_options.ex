defmodule Gleanex.Client.SearchRequestOptions do
  @moduledoc """
  Provides struct and type for a SearchRequestOptions
  """

  @type t :: %__MODULE__{
          authTokens: [Gleanex.Client.AuthToken.t()] | nil,
          datasourceFilter: String.t() | nil,
          datasourcesFilter: [String.t()] | nil,
          defaultFacets: [String.t()] | nil,
          disableQueryAutocorrect: boolean | nil,
          disableSpellcheck: boolean | nil,
          exclusions: Gleanex.Client.RestrictionFilters.t() | nil,
          facetBucketFilter: Gleanex.Client.FacetBucketFilter.t() | nil,
          facetBucketSize: integer,
          facetFilterSets: [Gleanex.Client.FacetFilterSet.t()] | nil,
          facetFilters: [Gleanex.Client.FacetFilter.t()] | nil,
          fetchAllDatasourceCounts: boolean | nil,
          inclusions: Gleanex.Client.RestrictionFilters.t() | nil,
          queryOverridesFacetFilters: boolean | nil,
          responseHints: [String.t()] | nil,
          returnLlmContentOverSnippets: boolean | nil,
          timezoneOffset: integer | nil
        }

  defstruct [
    :authTokens,
    :datasourceFilter,
    :datasourcesFilter,
    :defaultFacets,
    :disableQueryAutocorrect,
    :disableSpellcheck,
    :exclusions,
    :facetBucketFilter,
    :facetBucketSize,
    :facetFilterSets,
    :facetFilters,
    :fetchAllDatasourceCounts,
    :inclusions,
    :queryOverridesFacetFilters,
    :responseHints,
    :returnLlmContentOverSnippets,
    :timezoneOffset
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      authTokens: [{Gleanex.Client.AuthToken, :t}],
      datasourceFilter: :string,
      datasourcesFilter: [:string],
      defaultFacets: [:string],
      disableQueryAutocorrect: :boolean,
      disableSpellcheck: :boolean,
      exclusions: {Gleanex.Client.RestrictionFilters, :t},
      facetBucketFilter: {Gleanex.Client.FacetBucketFilter, :t},
      facetBucketSize: :integer,
      facetFilterSets: [{Gleanex.Client.FacetFilterSet, :t}],
      facetFilters: [{Gleanex.Client.FacetFilter, :t}],
      fetchAllDatasourceCounts: :boolean,
      inclusions: {Gleanex.Client.RestrictionFilters, :t},
      queryOverridesFacetFilters: :boolean,
      responseHints: [
        enum: [
          "ALL_RESULT_COUNTS",
          "FACET_RESULTS",
          "QUERY_METADATA",
          "RESULTS",
          "SPELLCHECK_METADATA"
        ]
      ],
      returnLlmContentOverSnippets: :boolean,
      timezoneOffset: :integer
    ]
  end
end
