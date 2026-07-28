defmodule Gleanex.Client.ShortcutMutableProperties do
  @moduledoc """
  Provides struct and type for a ShortcutMutableProperties
  """

  @type t :: %__MODULE__{
          addedRoles: [Gleanex.Client.UserRoleSpecification.t()] | nil,
          description: String.t() | nil,
          destinationDocumentId: String.t() | nil,
          destinationUrl: String.t() | nil,
          inputAlias: String.t() | nil,
          removedRoles: [Gleanex.Client.UserRoleSpecification.t()] | nil,
          unlisted: boolean | nil,
          urlTemplate: String.t() | nil
        }

  defstruct [
    :addedRoles,
    :description,
    :destinationDocumentId,
    :destinationUrl,
    :inputAlias,
    :removedRoles,
    :unlisted,
    :urlTemplate
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      addedRoles: [{Gleanex.Client.UserRoleSpecification, :t}],
      description: :string,
      destinationDocumentId: :string,
      destinationUrl: :string,
      inputAlias: :string,
      removedRoles: [{Gleanex.Client.UserRoleSpecification, :t}],
      unlisted: :boolean,
      urlTemplate: :string
    ]
  end
end
