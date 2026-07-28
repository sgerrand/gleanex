defmodule Gleanex.Client.PromptTemplate do
  @moduledoc """
  Provides struct and type for a PromptTemplate
  """

  @type t :: %__MODULE__{
          addedRoles: [Gleanex.Client.UserRoleSpecification.t()] | nil,
          applicationId: String.t() | nil,
          author: Gleanex.Client.Person.t() | nil,
          createTimestamp: integer | nil,
          id: String.t() | nil,
          inclusions: Gleanex.Client.ChatRestrictionFilters.t() | nil,
          lastUpdateTimestamp: integer | nil,
          lastUpdatedBy: Gleanex.Client.Person.t() | nil,
          name: String.t() | nil,
          permissions: Gleanex.Client.ObjectPermissions.t() | nil,
          removedRoles: [Gleanex.Client.UserRoleSpecification.t()] | nil,
          roles: [Gleanex.Client.UserRoleSpecification.t()] | nil,
          template: String.t() | nil
        }

  defstruct [
    :addedRoles,
    :applicationId,
    :author,
    :createTimestamp,
    :id,
    :inclusions,
    :lastUpdateTimestamp,
    :lastUpdatedBy,
    :name,
    :permissions,
    :removedRoles,
    :roles,
    :template
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      addedRoles: [{Gleanex.Client.UserRoleSpecification, :t}],
      applicationId: :string,
      author: {Gleanex.Client.Person, :t},
      createTimestamp: :integer,
      id: :string,
      inclusions: {Gleanex.Client.ChatRestrictionFilters, :t},
      lastUpdateTimestamp: :integer,
      lastUpdatedBy: {Gleanex.Client.Person, :t},
      name: :string,
      permissions: {Gleanex.Client.ObjectPermissions, :t},
      removedRoles: [{Gleanex.Client.UserRoleSpecification, :t}],
      roles: [{Gleanex.Client.UserRoleSpecification, :t}],
      template: :string
    ]
  end
end
