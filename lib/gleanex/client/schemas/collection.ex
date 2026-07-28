defmodule Gleanex.Client.Collection do
  @moduledoc """
  Provides struct and type for a Collection
  """

  @type t :: %__MODULE__{
          childCount: integer | nil,
          children: [Gleanex.Client.Collection.t()] | nil,
          createTime: DateTime.t() | nil,
          creator: Gleanex.Client.Person.t() | nil,
          favoriteInfo: Gleanex.Client.FavoriteInfo.t() | nil,
          id: integer | nil,
          itemCount: integer | nil,
          items: [Gleanex.Client.CollectionItem.t()] | nil,
          permissions: Gleanex.Client.ObjectPermissions.t() | nil,
          pinMetadata: Gleanex.Client.CollectionPinnedMetadata.t() | nil,
          roles: [Gleanex.Client.UserRoleSpecification.t()] | nil,
          shortcuts: [String.t()] | nil,
          trackingToken: String.t() | nil,
          updateTime: DateTime.t() | nil,
          updatedBy: Gleanex.Client.Person.t() | nil
        }

  defstruct [
    :childCount,
    :children,
    :createTime,
    :creator,
    :favoriteInfo,
    :id,
    :itemCount,
    :items,
    :permissions,
    :pinMetadata,
    :roles,
    :shortcuts,
    :trackingToken,
    :updateTime,
    :updatedBy
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      childCount: :integer,
      children: [{Gleanex.Client.Collection, :t}],
      createTime: {:string, "date-time"},
      creator: {Gleanex.Client.Person, :t},
      favoriteInfo: {Gleanex.Client.FavoriteInfo, :t},
      id: :integer,
      itemCount: :integer,
      items: [{Gleanex.Client.CollectionItem, :t}],
      permissions: {Gleanex.Client.ObjectPermissions, :t},
      pinMetadata: {Gleanex.Client.CollectionPinnedMetadata, :t},
      roles: [{Gleanex.Client.UserRoleSpecification, :t}],
      shortcuts: [:string],
      trackingToken: :string,
      updateTime: {:string, "date-time"},
      updatedBy: {Gleanex.Client.Person, :t}
    ]
  end
end
