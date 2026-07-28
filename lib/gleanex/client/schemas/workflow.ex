defmodule Gleanex.Client.Workflow do
  @moduledoc """
  Provides struct and type for a Workflow
  """

  @type t :: %__MODULE__{
          id: String.t() | nil,
          permissions: Gleanex.Client.ObjectPermissions.t() | nil,
          showOrganizationAsAuthor: boolean | nil,
          verified: boolean | nil,
          webhookUrl: String.t() | nil
        }

  defstruct [:id, :permissions, :showOrganizationAsAuthor, :verified, :webhookUrl]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      id: :string,
      permissions: {Gleanex.Client.ObjectPermissions, :t},
      showOrganizationAsAuthor: :boolean,
      verified: :boolean,
      webhookUrl: :string
    ]
  end
end
