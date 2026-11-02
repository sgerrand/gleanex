defmodule Gleanex.Platform.UserDatasourceProfile do
  @moduledoc """
  Provides struct and type for a UserDatasourceProfile
  """

  @type t :: %__MODULE__{
          account_id: String.t() | nil,
          datasource: String.t(),
          handle: String.t(),
          profile_url: String.t() | nil
        }

  defstruct [:account_id, :datasource, :handle, :profile_url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [account_id: :string, datasource: :string, handle: :string, profile_url: :string]
  end
end
