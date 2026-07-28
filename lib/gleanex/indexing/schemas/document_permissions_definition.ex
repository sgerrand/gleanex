defmodule Gleanex.Indexing.DocumentPermissionsDefinition do
  @moduledoc """
  Provides struct and type for a DocumentPermissionsDefinition
  """

  @type t :: %__MODULE__{
          allowAllDatasourceUsersAccess: boolean | nil,
          allowAnonymousAccess: boolean | nil,
          allowedGroupIntersections:
            [Gleanex.Indexing.PermissionsGroupIntersectionDefinition.t()] | nil,
          allowedGroups: [String.t()] | nil,
          allowedUsers: [Gleanex.Indexing.UserReferenceDefinition.t()] | nil
        }

  defstruct [
    :allowAllDatasourceUsersAccess,
    :allowAnonymousAccess,
    :allowedGroupIntersections,
    :allowedGroups,
    :allowedUsers
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      allowAllDatasourceUsersAccess: :boolean,
      allowAnonymousAccess: :boolean,
      allowedGroupIntersections: [{Gleanex.Indexing.PermissionsGroupIntersectionDefinition, :t}],
      allowedGroups: [:string],
      allowedUsers: [{Gleanex.Indexing.UserReferenceDefinition, :t}]
    ]
  end
end
