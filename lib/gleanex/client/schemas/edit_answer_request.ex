defmodule Gleanex.Client.EditAnswerRequest do
  @moduledoc """
  Provides struct and type for a EditAnswerRequest
  """

  @type t :: %__MODULE__{
          addedCollections: [integer] | nil,
          addedRoles: [Gleanex.Client.UserRoleSpecification.t()] | nil,
          audienceFilters: [Gleanex.Client.FacetFilter.t()] | nil,
          boardId: integer | nil,
          bodyText: String.t() | nil,
          combinedAnswerText: Gleanex.Client.StructuredTextMutableProperties.t() | nil,
          docId: String.t() | nil,
          id: integer | nil,
          question: String.t() | nil,
          questionVariations: [String.t()] | nil,
          removedCollections: [integer] | nil,
          removedRoles: [Gleanex.Client.UserRoleSpecification.t()] | nil,
          roles: [Gleanex.Client.UserRoleSpecification.t()] | nil,
          sourceDocumentSpec: map | nil,
          sourceType: String.t() | nil
        }

  defstruct [
    :addedCollections,
    :addedRoles,
    :audienceFilters,
    :boardId,
    :bodyText,
    :combinedAnswerText,
    :docId,
    :id,
    :question,
    :questionVariations,
    :removedCollections,
    :removedRoles,
    :roles,
    :sourceDocumentSpec,
    :sourceType
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      addedCollections: [:integer],
      addedRoles: [{Gleanex.Client.UserRoleSpecification, :t}],
      audienceFilters: [{Gleanex.Client.FacetFilter, :t}],
      boardId: :integer,
      bodyText: :string,
      combinedAnswerText: {Gleanex.Client.StructuredTextMutableProperties, :t},
      docId: :string,
      id: :integer,
      question: :string,
      questionVariations: [:string],
      removedCollections: [:integer],
      removedRoles: [{Gleanex.Client.UserRoleSpecification, :t}],
      roles: [{Gleanex.Client.UserRoleSpecification, :t}],
      sourceDocumentSpec: :map,
      sourceType: {:enum, ["DOCUMENT", "ASSISTANT"]}
    ]
  end
end
