defmodule Gleanex.Indexing.TeamInfoDefinition do
  @moduledoc """
  Provides struct and type for a TeamInfoDefinition
  """

  @type t :: %__MODULE__{
          additionalFields: [Gleanex.Indexing.AdditionalFieldDefinition.t()] | nil,
          businessUnit: String.t() | nil,
          datasourceProfiles: [Gleanex.Indexing.DatasourceProfile.t()] | nil,
          department: String.t() | nil,
          description: String.t() | nil,
          emails: [Gleanex.Indexing.TeamEmail.t()] | nil,
          externalLink: String.t() | nil,
          id: String.t(),
          members: [Gleanex.Indexing.TeamMember.t()],
          name: String.t(),
          photoUrl: String.t() | nil
        }

  defstruct [
    :additionalFields,
    :businessUnit,
    :datasourceProfiles,
    :department,
    :description,
    :emails,
    :externalLink,
    :id,
    :members,
    :name,
    :photoUrl
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      additionalFields: [{Gleanex.Indexing.AdditionalFieldDefinition, :t}],
      businessUnit: :string,
      datasourceProfiles: [{Gleanex.Indexing.DatasourceProfile, :t}],
      department: :string,
      description: :string,
      emails: [{Gleanex.Indexing.TeamEmail, :t}],
      externalLink: {:string, "uri"},
      id: :string,
      members: [{Gleanex.Indexing.TeamMember, :t}],
      name: :string,
      photoUrl: {:string, "uri"}
    ]
  end
end
