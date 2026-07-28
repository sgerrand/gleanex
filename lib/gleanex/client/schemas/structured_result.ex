defmodule Gleanex.Client.StructuredResult do
  @moduledoc """
  Provides struct and type for a StructuredResult
  """

  @type t :: %__MODULE__{
          answer: Gleanex.Client.Answer.t() | nil,
          app: Gleanex.Client.AppResult.t() | nil,
          chat: Gleanex.Client.ChatMetadata.t() | nil,
          code: Gleanex.Client.Code.t() | nil,
          collection: Gleanex.Client.Collection.t() | nil,
          customEntity: Gleanex.Client.CustomEntity.t() | nil,
          customer: Gleanex.Client.Customer.t() | nil,
          disambiguation: Gleanex.Client.Disambiguation.t() | nil,
          document: Gleanex.Client.Document.t() | nil,
          extractedQnA: Gleanex.Client.ExtractedQnA.t() | nil,
          generatedQna: Gleanex.Client.GeneratedQna.t() | nil,
          meeting: Gleanex.Client.Meeting.t() | nil,
          person: Gleanex.Client.Person.t() | nil,
          prominence: String.t() | nil,
          querySuggestions: Gleanex.Client.QuerySuggestionList.t() | nil,
          relatedDocuments: [Gleanex.Client.RelatedDocuments.t()] | nil,
          relatedQuestion: Gleanex.Client.RelatedQuestion.t() | nil,
          shortcut: Gleanex.Client.Shortcut.t() | nil,
          snippets: [Gleanex.Client.SearchResultSnippet.t()] | nil,
          source: String.t() | nil,
          team: Gleanex.Client.Team.t() | nil,
          trackingToken: String.t() | nil
        }

  defstruct [
    :answer,
    :app,
    :chat,
    :code,
    :collection,
    :customEntity,
    :customer,
    :disambiguation,
    :document,
    :extractedQnA,
    :generatedQna,
    :meeting,
    :person,
    :prominence,
    :querySuggestions,
    :relatedDocuments,
    :relatedQuestion,
    :shortcut,
    :snippets,
    :source,
    :team,
    :trackingToken
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      answer: {Gleanex.Client.Answer, :t},
      app: {Gleanex.Client.AppResult, :t},
      chat: {Gleanex.Client.ChatMetadata, :t},
      code: {Gleanex.Client.Code, :t},
      collection: {Gleanex.Client.Collection, :t},
      customEntity: {Gleanex.Client.CustomEntity, :t},
      customer: {Gleanex.Client.Customer, :t},
      disambiguation: {Gleanex.Client.Disambiguation, :t},
      document: {Gleanex.Client.Document, :t},
      extractedQnA: {Gleanex.Client.ExtractedQnA, :t},
      generatedQna: {Gleanex.Client.GeneratedQna, :t},
      meeting: {Gleanex.Client.Meeting, :t},
      person: {Gleanex.Client.Person, :t},
      prominence: {:enum, ["HERO", "PROMOTED", "STANDARD"]},
      querySuggestions: {Gleanex.Client.QuerySuggestionList, :t},
      relatedDocuments: [{Gleanex.Client.RelatedDocuments, :t}],
      relatedQuestion: {Gleanex.Client.RelatedQuestion, :t},
      shortcut: {Gleanex.Client.Shortcut, :t},
      snippets: [{Gleanex.Client.SearchResultSnippet, :t}],
      source: {:enum, ["EXPERT_DETECTION", "ENTITY_NLQ", "CALENDAR_EVENT", "AGENT"]},
      team: {Gleanex.Client.Team, :t},
      trackingToken: :string
    ]
  end
end
