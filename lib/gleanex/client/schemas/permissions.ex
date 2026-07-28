defmodule Gleanex.Client.Permissions do
  @moduledoc """
  Provides struct and type for a Permissions
  """

  @type t :: %__MODULE__{
          canAdminClientApiGlobalTokens: boolean | nil,
          canAdminSearch: boolean | nil,
          canDlp: boolean | nil,
          grant: map | nil,
          read: map | nil,
          role: String.t() | nil,
          roles: [String.t()] | nil,
          write: map | nil
        }

  defstruct [
    :canAdminClientApiGlobalTokens,
    :canAdminSearch,
    :canDlp,
    :grant,
    :read,
    :role,
    :roles,
    :write
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      canAdminClientApiGlobalTokens: :boolean,
      canAdminSearch: :boolean,
      canDlp: :boolean,
      grant: :map,
      read: :map,
      role: :string,
      roles: [:string],
      write: :map
    ]
  end
end
