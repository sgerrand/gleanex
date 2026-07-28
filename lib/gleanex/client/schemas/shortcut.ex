defmodule Gleanex.Client.Shortcut do
  @moduledoc """
  Provides struct and type for a Shortcut
  """

  @type t :: %__MODULE__{
          addedRoles: [Gleanex.Client.UserRoleSpecification.t()] | nil,
          alias: String.t() | nil,
          createTime: DateTime.t() | nil,
          createdBy: Gleanex.Client.Person.t() | nil,
          description: String.t() | nil,
          destinationDocument: Gleanex.Client.Document.t() | nil,
          destinationDocumentId: String.t() | nil,
          destinationUrl: String.t() | nil,
          editUrl: String.t() | nil,
          favoriteInfo: Gleanex.Client.FavoriteInfo.t() | nil,
          id: integer | nil,
          inputAlias: String.t() | nil,
          intermediateUrl: String.t() | nil,
          isExternal: boolean | nil,
          permissions: Gleanex.Client.ObjectPermissions.t() | nil,
          removedRoles: [Gleanex.Client.UserRoleSpecification.t()] | nil,
          roles: [Gleanex.Client.UserRoleSpecification.t()] | nil,
          title: String.t() | nil,
          unlisted: boolean | nil,
          updateTime: DateTime.t() | nil,
          updatedBy: Gleanex.Client.Person.t() | nil,
          urlTemplate: String.t() | nil,
          viewPrefix: String.t() | nil
        }

  defstruct [
    :addedRoles,
    :alias,
    :createTime,
    :createdBy,
    :description,
    :destinationDocument,
    :destinationDocumentId,
    :destinationUrl,
    :editUrl,
    :favoriteInfo,
    :id,
    :inputAlias,
    :intermediateUrl,
    :isExternal,
    :permissions,
    :removedRoles,
    :roles,
    :title,
    :unlisted,
    :updateTime,
    :updatedBy,
    :urlTemplate,
    :viewPrefix
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      addedRoles: [{Gleanex.Client.UserRoleSpecification, :t}],
      alias: :string,
      createTime: {:string, "date-time"},
      createdBy: {Gleanex.Client.Person, :t},
      description: :string,
      destinationDocument: {Gleanex.Client.Document, :t},
      destinationDocumentId: :string,
      destinationUrl: :string,
      editUrl: :string,
      favoriteInfo: {Gleanex.Client.FavoriteInfo, :t},
      id: :integer,
      inputAlias: :string,
      intermediateUrl: :string,
      isExternal: :boolean,
      permissions: {Gleanex.Client.ObjectPermissions, :t},
      removedRoles: [{Gleanex.Client.UserRoleSpecification, :t}],
      roles: [{Gleanex.Client.UserRoleSpecification, :t}],
      title: :string,
      unlisted: :boolean,
      updateTime: {:string, "date-time"},
      updatedBy: {Gleanex.Client.Person, :t},
      urlTemplate: :string,
      viewPrefix: :string
    ]
  end
end
