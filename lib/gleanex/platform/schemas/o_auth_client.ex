defmodule Gleanex.Platform.OAuthClient do
  @moduledoc """
  Provides struct and type for a OAuthClient
  """

  @type t :: %__MODULE__{
          ai_gateway: Gleanex.Platform.OAuthClientAiGateway.t() | nil,
          client_id: String.t(),
          client_type: String.t() | nil,
          created_at: DateTime.t() | nil,
          display_name: String.t(),
          grant_types: [String.t()],
          is_active: boolean,
          redirect_uris: [String.t()],
          registration_type: String.t(),
          token_endpoint_auth_method: String.t() | nil
        }

  defstruct [
    :ai_gateway,
    :client_id,
    :client_type,
    :created_at,
    :display_name,
    :grant_types,
    :is_active,
    :redirect_uris,
    :registration_type,
    :token_endpoint_auth_method
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      ai_gateway: {Gleanex.Platform.OAuthClientAiGateway, :t},
      client_id: :string,
      client_type: {:enum, ["CONFIDENTIAL", "PUBLIC"]},
      created_at: {:string, "date-time"},
      display_name: :string,
      grant_types: [
        enum: [
          "AUTHORIZATION_CODE",
          "CLIENT_CREDENTIALS",
          "REFRESH_TOKEN",
          "DEVICE_CODE",
          "TOKEN_EXCHANGE",
          "JWT_BEARER"
        ]
      ],
      is_active: :boolean,
      redirect_uris: [:string],
      registration_type: {:const, "STATIC"},
      token_endpoint_auth_method:
        {:enum,
         [
           "CLIENT_SECRET_BASIC",
           "CLIENT_SECRET_POST",
           "NO_AUTHENTICATION",
           "PRIVATE_KEY_JWT",
           "TLS_CLIENT_AUTH"
         ]}
    ]
  end
end
