defmodule Gleanex.Indexing.EmployeeInfoDefinition do
  @moduledoc """
  Provides struct and type for a EmployeeInfoDefinition
  """

  @type t :: %__MODULE__{
          additionalFields: [Gleanex.Indexing.AdditionalFieldDefinition.t()] | nil,
          alsoKnownAs: [String.t()] | nil,
          bio: String.t() | nil,
          businessUnit: String.t() | nil,
          datasourceProfiles: [Gleanex.Indexing.DatasourceProfile.t()] | nil,
          department: String.t(),
          email: String.t(),
          endDate: Date.t() | nil,
          firstName: String.t() | nil,
          id: String.t() | nil,
          lastName: String.t() | nil,
          location: String.t() | nil,
          managerEmail: String.t() | nil,
          managerId: String.t() | nil,
          phoneNumber: String.t() | nil,
          photoUrl: String.t() | nil,
          preferredName: String.t() | nil,
          profileUrl: String.t() | nil,
          pronoun: String.t() | nil,
          relationships: [Gleanex.Indexing.EntityRelationship.t()] | nil,
          socialNetworks: [Gleanex.Indexing.SocialNetworkDefinition.t()] | nil,
          startDate: Date.t() | nil,
          status: String.t() | nil,
          structuredLocation: Gleanex.Indexing.StructuredLocation.t() | nil,
          teams: [Gleanex.Indexing.EmployeeTeamInfo.t()] | nil,
          title: String.t() | nil,
          type: String.t() | nil
        }

  defstruct [
    :additionalFields,
    :alsoKnownAs,
    :bio,
    :businessUnit,
    :datasourceProfiles,
    :department,
    :email,
    :endDate,
    :firstName,
    :id,
    :lastName,
    :location,
    :managerEmail,
    :managerId,
    :phoneNumber,
    :photoUrl,
    :preferredName,
    :profileUrl,
    :pronoun,
    :relationships,
    :socialNetworks,
    :startDate,
    :status,
    :structuredLocation,
    :teams,
    :title,
    :type
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      additionalFields: [{Gleanex.Indexing.AdditionalFieldDefinition, :t}],
      alsoKnownAs: [:string],
      bio: :string,
      businessUnit: :string,
      datasourceProfiles: [{Gleanex.Indexing.DatasourceProfile, :t}],
      department: :string,
      email: :string,
      endDate: {:string, "date"},
      firstName: :string,
      id: :string,
      lastName: :string,
      location: :string,
      managerEmail: :string,
      managerId: :string,
      phoneNumber: :string,
      photoUrl: {:string, "uri"},
      preferredName: :string,
      profileUrl: :string,
      pronoun: :string,
      relationships: [{Gleanex.Indexing.EntityRelationship, :t}],
      socialNetworks: [{Gleanex.Indexing.SocialNetworkDefinition, :t}],
      startDate: {:string, "date"},
      status: :string,
      structuredLocation: {Gleanex.Indexing.StructuredLocation, :t},
      teams: [{Gleanex.Indexing.EmployeeTeamInfo, :t}],
      title: :string,
      type: :string
    ]
  end
end
