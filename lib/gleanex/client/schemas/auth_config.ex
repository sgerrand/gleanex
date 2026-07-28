defmodule Gleanex.Client.AuthConfig do
  @moduledoc """
  Provides struct and type for a AuthConfig
  """

  @type t :: %__MODULE__{
          audiences: [String.t()] | nil,
          authHeaderType: String.t() | nil,
          authorization_url: String.t() | nil,
          client_url: String.t() | nil,
          grantType: String.t() | nil,
          isOnPrem: boolean | nil,
          lastAuthorizedAt: DateTime.t() | nil,
          resource: String.t() | nil,
          scopes: [String.t()] | nil,
          status: String.t() | nil,
          token_endpoint_auth_method: String.t() | nil,
          type: String.t() | nil,
          usesCentralAuth: boolean | nil
        }

  defstruct [
    :audiences,
    :authHeaderType,
    :authorization_url,
    :client_url,
    :grantType,
    :isOnPrem,
    :lastAuthorizedAt,
    :resource,
    :scopes,
    :status,
    :token_endpoint_auth_method,
    :type,
    :usesCentralAuth
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      audiences: [:string],
      authHeaderType:
        {:enum,
         ["AUTHORIZATION_BEARER", "AUTHORIZATION_TOKEN", "AUTHORIZATION_API_KEY", "X_API_KEY"]},
      authorization_url: {:string, "url"},
      client_url: {:string, "url"},
      grantType: {:enum, ["AUTH_CODE", "CLIENT_CREDENTIALS"]},
      isOnPrem: :boolean,
      lastAuthorizedAt: {:string, "date-time"},
      resource: {:string, "url"},
      scopes: [:string],
      status: {:enum, ["AWAITING_AUTH", "AUTHORIZED", "AUTH_DISABLED"]},
      token_endpoint_auth_method:
        {:enum, ["client_secret_post", "client_secret_basic", "none", "private_key_jwt"]},
      type: {:enum, ["NONE", "OAUTH_USER", "OAUTH_ADMIN", "API_KEY", "BASIC_AUTH", "DWD"]},
      usesCentralAuth: :boolean
    ]
  end
end
