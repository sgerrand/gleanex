defmodule Gleanex.Client.RelatedDocuments do
  @moduledoc """
  Provides struct and type for a RelatedDocuments
  """

  @type t :: %__MODULE__{
          associatedEntityId: String.t() | nil,
          documents: [Gleanex.Client.Document.t()] | nil,
          querySuggestion: Gleanex.Client.QuerySuggestion.t() | nil,
          relation: String.t() | nil,
          results: [Gleanex.Client.SearchResult.t()] | nil
        }

  defstruct [:associatedEntityId, :documents, :querySuggestion, :relation, :results]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      associatedEntityId: :string,
      documents: [{Gleanex.Client.Document, :t}],
      querySuggestion: {Gleanex.Client.QuerySuggestion, :t},
      relation:
        {:enum,
         [
           "ATTACHMENT",
           "CANONICAL",
           "CASE",
           "contact",
           "CONTACT",
           "CONVERSATION_MESSAGES",
           "EXPERT",
           "FROM",
           "HIGHLIGHT",
           "opportunity",
           "OPPORTUNITY",
           "RECENT",
           "SOURCE",
           "TICKET",
           "TRANSCRIPT",
           "WITH"
         ]},
      results: [{Gleanex.Client.SearchResult, :t}]
    ]
  end
end
