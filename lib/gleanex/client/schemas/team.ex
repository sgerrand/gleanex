defmodule Gleanex.Client.Team do
  @moduledoc """
  Provides struct and type for a Team
  """

  @type t :: %__MODULE__{
          bannerUrl: String.t() | nil,
          businessUnit: String.t() | nil,
          canBeDeleted: boolean | nil,
          createdFrom: String.t() | nil,
          customFields: [Gleanex.Client.CustomFieldData.t()] | nil,
          datasource: String.t() | nil,
          datasourceProfiles: [Gleanex.Client.DatasourceProfile.t()] | nil,
          department: String.t() | nil,
          description: String.t() | nil,
          emails: [Gleanex.Client.TeamEmail.t()] | nil,
          externalLink: String.t() | nil,
          id: String.t() | nil,
          lastUpdatedAt: DateTime.t() | nil,
          loggingId: String.t() | nil,
          memberCount: integer | nil,
          members: [Gleanex.Client.PersonToTeamRelationship.t()] | nil,
          name: String.t() | nil,
          permissions: Gleanex.Client.ObjectPermissions.t() | nil,
          photoUrl: String.t() | nil,
          relatedObjects: map | nil,
          status: String.t() | nil
        }

  defstruct [
    :bannerUrl,
    :businessUnit,
    :canBeDeleted,
    :createdFrom,
    :customFields,
    :datasource,
    :datasourceProfiles,
    :department,
    :description,
    :emails,
    :externalLink,
    :id,
    :lastUpdatedAt,
    :loggingId,
    :memberCount,
    :members,
    :name,
    :permissions,
    :photoUrl,
    :relatedObjects,
    :status
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      bannerUrl: {:string, "url"},
      businessUnit: :string,
      canBeDeleted: :boolean,
      createdFrom: :string,
      customFields: [{Gleanex.Client.CustomFieldData, :t}],
      datasource: :string,
      datasourceProfiles: [{Gleanex.Client.DatasourceProfile, :t}],
      department: :string,
      description: :string,
      emails: [{Gleanex.Client.TeamEmail, :t}],
      externalLink: {:string, "uri"},
      id: :string,
      lastUpdatedAt: {:string, "date-time"},
      loggingId: :string,
      memberCount: :integer,
      members: [{Gleanex.Client.PersonToTeamRelationship, :t}],
      name: :string,
      permissions: {Gleanex.Client.ObjectPermissions, :t},
      photoUrl: {:string, "url"},
      relatedObjects: :map,
      status: {:enum, ["PROCESSED", "QUEUED_FOR_CREATION", "QUEUED_FOR_DELETION"]}
    ]
  end
end
