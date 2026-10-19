defmodule Gleanex.Platform.User do
  @moduledoc """
  Provides struct and type for a User
  """

  @type t :: %__MODULE__{
          alias_emails: [String.t()] | nil,
          datasource_profiles: [Gleanex.Platform.UserDatasourceProfile.t()] | nil,
          department: Gleanex.Platform.DepartmentReference.t() | nil,
          display_name: String.t(),
          email: String.t() | nil,
          is_active: boolean,
          manager: Gleanex.Platform.UserManager.t() | nil,
          photo_url: String.t() | nil,
          title: String.t() | nil,
          user_id: String.t(),
          user_type: String.t() | nil
        }

  defstruct [
    :alias_emails,
    :datasource_profiles,
    :department,
    :display_name,
    :email,
    :is_active,
    :manager,
    :photo_url,
    :title,
    :user_id,
    :user_type
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      alias_emails: [:string],
      datasource_profiles: [{Gleanex.Platform.UserDatasourceProfile, :t}],
      department: {Gleanex.Platform.DepartmentReference, :t},
      display_name: :string,
      email: :string,
      is_active: :boolean,
      manager: {Gleanex.Platform.UserManager, :t},
      photo_url: :string,
      title: :string,
      user_id: :string,
      user_type: {:enum, ["FULL_TIME", "CONTRACTOR", "NON_EMPLOYEE", "FORMER_EMPLOYEE"]}
    ]
  end
end
