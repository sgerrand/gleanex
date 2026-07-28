defmodule Gleanex.Client.CustomEntity do
  @moduledoc """
  Provides struct and type for a CustomEntity
  """

  @type t :: %__MODULE__{
          datasource: String.t() | nil,
          id: String.t() | nil,
          metadata: Gleanex.Client.CustomEntityMetadata.t() | nil,
          objectType: String.t() | nil,
          permissions: Gleanex.Client.ObjectPermissions.t() | nil,
          roles: [Gleanex.Client.UserRoleSpecification.t()] | nil,
          title: String.t() | nil
        }

  defstruct [:datasource, :id, :metadata, :objectType, :permissions, :roles, :title]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasource: :string,
      id: :string,
      metadata: {Gleanex.Client.CustomEntityMetadata, :t},
      objectType: :string,
      permissions: {Gleanex.Client.ObjectPermissions, :t},
      roles: [{Gleanex.Client.UserRoleSpecification, :t}],
      title: :string
    ]
  end
end
