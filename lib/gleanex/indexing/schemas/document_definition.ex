defmodule Gleanex.Indexing.DocumentDefinition do
  @moduledoc """
  Provides struct and type for a DocumentDefinition
  """

  @type t :: %__MODULE__{
          additionalUrls: [String.t()] | nil,
          author: Gleanex.Indexing.UserReferenceDefinition.t() | nil,
          body: Gleanex.Indexing.ContentDefinition.t() | nil,
          comments: [Gleanex.Indexing.CommentDefinition.t()] | nil,
          container: String.t() | nil,
          containerDatasourceId: String.t() | nil,
          containerObjectType: String.t() | nil,
          createdAt: integer | nil,
          customProperties: [Gleanex.Indexing.CustomProperty.t()] | nil,
          datasource: String.t(),
          filename: String.t() | nil,
          id: String.t() | nil,
          interactions: Gleanex.Indexing.DocumentInteractionsDefinition.t() | nil,
          nativeAppUrl: String.t() | nil,
          objectType: String.t() | nil,
          owner: Gleanex.Indexing.UserReferenceDefinition.t() | nil,
          permissions: Gleanex.Indexing.DocumentPermissionsDefinition.t() | nil,
          status: String.t() | nil,
          summary: Gleanex.Indexing.ContentDefinition.t() | nil,
          tags: [String.t()] | nil,
          title: String.t() | nil,
          updatedAt: integer | nil,
          updatedBy: Gleanex.Indexing.UserReferenceDefinition.t() | nil,
          viewURL: String.t() | nil
        }

  defstruct [
    :additionalUrls,
    :author,
    :body,
    :comments,
    :container,
    :containerDatasourceId,
    :containerObjectType,
    :createdAt,
    :customProperties,
    :datasource,
    :filename,
    :id,
    :interactions,
    :nativeAppUrl,
    :objectType,
    :owner,
    :permissions,
    :status,
    :summary,
    :tags,
    :title,
    :updatedAt,
    :updatedBy,
    :viewURL
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      additionalUrls: [:string],
      author: {Gleanex.Indexing.UserReferenceDefinition, :t},
      body: {Gleanex.Indexing.ContentDefinition, :t},
      comments: [{Gleanex.Indexing.CommentDefinition, :t}],
      container: :string,
      containerDatasourceId: :string,
      containerObjectType: :string,
      createdAt: {:integer, "int64"},
      customProperties: [{Gleanex.Indexing.CustomProperty, :t}],
      datasource: :string,
      filename: :string,
      id: :string,
      interactions: {Gleanex.Indexing.DocumentInteractionsDefinition, :t},
      nativeAppUrl: :string,
      objectType: :string,
      owner: {Gleanex.Indexing.UserReferenceDefinition, :t},
      permissions: {Gleanex.Indexing.DocumentPermissionsDefinition, :t},
      status: :string,
      summary: {Gleanex.Indexing.ContentDefinition, :t},
      tags: [:string],
      title: :string,
      updatedAt: {:integer, "int64"},
      updatedBy: {Gleanex.Indexing.UserReferenceDefinition, :t},
      viewURL: :string
    ]
  end
end
