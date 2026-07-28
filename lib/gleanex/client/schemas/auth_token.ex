defmodule Gleanex.Client.AuthToken do
  @moduledoc """
  Provides struct and type for a AuthToken
  """

  @type t :: %__MODULE__{
          accessToken: String.t(),
          authUser: String.t() | nil,
          datasource: String.t(),
          expiration: integer | nil,
          scope: String.t() | nil,
          tokenType: String.t() | nil
        }

  defstruct [:accessToken, :authUser, :datasource, :expiration, :scope, :tokenType]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      accessToken: :string,
      authUser: :string,
      datasource: :string,
      expiration: {:integer, "int64"},
      scope: :string,
      tokenType: :string
    ]
  end
end
