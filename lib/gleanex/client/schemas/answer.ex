defmodule Gleanex.Client.Answer do
  @moduledoc """
  Provides struct and type for a Answer
  """

  @type t :: %__MODULE__{
          addedRoles: [Gleanex.Client.UserRoleSpecification.t()] | nil,
          audienceFilters: [Gleanex.Client.FacetFilter.t()] | nil,
          author: Gleanex.Client.Person.t() | nil,
          boardId: integer | nil,
          bodyText: String.t() | nil,
          collections: [Gleanex.Client.Collection.t()] | nil,
          combinedAnswerText: Gleanex.Client.StructuredText.t() | nil,
          createTime: DateTime.t() | nil,
          docId: String.t() | nil,
          documentCategory: String.t() | nil,
          id: integer | nil,
          likes: Gleanex.Client.AnswerLikes.t() | nil,
          permissions: Gleanex.Client.ObjectPermissions.t() | nil,
          question: String.t() | nil,
          questionVariations: [String.t()] | nil,
          removedRoles: [Gleanex.Client.UserRoleSpecification.t()] | nil,
          roles: [Gleanex.Client.UserRoleSpecification.t()] | nil,
          sourceDocument: Gleanex.Client.Document.t() | nil,
          sourceDocumentSpec: map | nil,
          sourceType: String.t() | nil,
          trackingToken: String.t() | nil,
          updateTime: DateTime.t() | nil,
          updatedBy: Gleanex.Client.Person.t() | nil,
          verification: Gleanex.Client.Verification.t() | nil
        }

  defstruct [
    :addedRoles,
    :audienceFilters,
    :author,
    :boardId,
    :bodyText,
    :collections,
    :combinedAnswerText,
    :createTime,
    :docId,
    :documentCategory,
    :id,
    :likes,
    :permissions,
    :question,
    :questionVariations,
    :removedRoles,
    :roles,
    :sourceDocument,
    :sourceDocumentSpec,
    :sourceType,
    :trackingToken,
    :updateTime,
    :updatedBy,
    :verification
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      addedRoles: [{Gleanex.Client.UserRoleSpecification, :t}],
      audienceFilters: [{Gleanex.Client.FacetFilter, :t}],
      author: {Gleanex.Client.Person, :t},
      boardId: :integer,
      bodyText: :string,
      collections: [{Gleanex.Client.Collection, :t}],
      combinedAnswerText: {Gleanex.Client.StructuredText, :t},
      createTime: {:string, "date-time"},
      docId: :string,
      documentCategory: :string,
      id: :integer,
      likes: {Gleanex.Client.AnswerLikes, :t},
      permissions: {Gleanex.Client.ObjectPermissions, :t},
      question: :string,
      questionVariations: [:string],
      removedRoles: [{Gleanex.Client.UserRoleSpecification, :t}],
      roles: [{Gleanex.Client.UserRoleSpecification, :t}],
      sourceDocument: {Gleanex.Client.Document, :t},
      sourceDocumentSpec: :map,
      sourceType: {:enum, ["DOCUMENT", "ASSISTANT"]},
      trackingToken: :string,
      updateTime: {:string, "date-time"},
      updatedBy: {Gleanex.Client.Person, :t},
      verification: {Gleanex.Client.Verification, :t}
    ]
  end
end
