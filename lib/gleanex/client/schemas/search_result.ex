defmodule Gleanex.Client.SearchResult do
  @moduledoc """
  Provides struct and type for a SearchResult
  """

  @type t :: %__MODULE__{
          allClusteredResults: [Gleanex.Client.ClusterGroup.t()] | nil,
          attachmentContext: String.t() | nil,
          attachmentCount: integer | nil,
          attachments: [Gleanex.Client.SearchResult.t()] | nil,
          backlinkResults: [Gleanex.Client.SearchResult.t()] | nil,
          clusterType: String.t() | nil,
          clusteredResults: [Gleanex.Client.SearchResult.t()] | nil,
          document: Gleanex.Client.Document.t() | nil,
          fullText: String.t() | nil,
          fullTextList: [String.t()] | nil,
          mustIncludeSuggestions: Gleanex.Client.QuerySuggestionList.t() | nil,
          nativeAppUrl: String.t() | nil,
          pins: [Gleanex.Client.PinDocument.t()] | nil,
          prominence: String.t() | nil,
          querySuggestion: Gleanex.Client.QuerySuggestion.t() | nil,
          relatedResults: [Gleanex.Client.RelatedDocuments.t()] | nil,
          snippets: [Gleanex.Client.SearchResultSnippet.t()] | nil,
          structuredResults: [Gleanex.Client.StructuredResult.t()] | nil,
          title: String.t() | nil,
          trackingToken: String.t() | nil,
          url: String.t()
        }

  defstruct [
    :allClusteredResults,
    :attachmentContext,
    :attachmentCount,
    :attachments,
    :backlinkResults,
    :clusterType,
    :clusteredResults,
    :document,
    :fullText,
    :fullTextList,
    :mustIncludeSuggestions,
    :nativeAppUrl,
    :pins,
    :prominence,
    :querySuggestion,
    :relatedResults,
    :snippets,
    :structuredResults,
    :title,
    :trackingToken,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      allClusteredResults: [{Gleanex.Client.ClusterGroup, :t}],
      attachmentContext: :string,
      attachmentCount: :integer,
      attachments: [{Gleanex.Client.SearchResult, :t}],
      backlinkResults: [{Gleanex.Client.SearchResult, :t}],
      clusterType:
        {:enum,
         [
           "SIMILAR",
           "FRESHNESS",
           "TITLE",
           "CONTENT",
           "NONE",
           "THREAD_REPLY",
           "THREAD_ROOT",
           "PREFIX",
           "SUFFIX",
           "AUTHOR_PREFIX",
           "AUTHOR_SUFFIX"
         ]},
      clusteredResults: [{Gleanex.Client.SearchResult, :t}],
      document: {Gleanex.Client.Document, :t},
      fullText: :string,
      fullTextList: [:string],
      mustIncludeSuggestions: {Gleanex.Client.QuerySuggestionList, :t},
      nativeAppUrl: :string,
      pins: [{Gleanex.Client.PinDocument, :t}],
      prominence: {:enum, ["HERO", "PROMOTED", "STANDARD"]},
      querySuggestion: {Gleanex.Client.QuerySuggestion, :t},
      relatedResults: [{Gleanex.Client.RelatedDocuments, :t}],
      snippets: [{Gleanex.Client.SearchResultSnippet, :t}],
      structuredResults: [{Gleanex.Client.StructuredResult, :t}],
      title: :string,
      trackingToken: :string,
      url: :string
    ]
  end
end
