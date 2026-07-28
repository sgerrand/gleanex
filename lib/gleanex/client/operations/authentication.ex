defmodule Gleanex.Client.Authentication do
  @moduledoc """
  Provides API endpoints related to authentication
  """

  @default_client Gleanex.HTTP

  @doc """
  Check datasource authorization

  Returns all datasource instances that require per-user OAuth authorization
  for the authenticated user, along with a transient auth token that can be
  appended to auth URLs to complete OAuth flows.

  Clients construct the full OAuth URL by combining the backend base URL,
  the `authUrlRelativePath` from each instance, and the transient auth token:
  `<backend>/<authUrlRelativePath>?transient_auth_token=<token>`.

  """
  @spec checkdatasourceauth(opts :: keyword) ::
          {:ok, Gleanex.Client.CheckDatasourceAuthResponse.t()} | {:error, Gleanex.Error.t()}
  def checkdatasourceauth(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Gleanex.Client.Authentication, :checkdatasourceauth},
      url: "/checkdatasourceauth",
      method: :post,
      response: [
        {200, {Gleanex.Client.CheckDatasourceAuthResponse, :t}},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Create authentication token

  Creates an authentication token for the authenticated user. These are
  specifically intended to be used with the [Web SDK](https://developers.glean.com/web).

  Note: The tokens generated from this endpoint are **not** valid tokens
  for use with the Client API (e.g. `/rest/api/v1/*`).

  """
  @spec createauthtoken(opts :: keyword) ::
          {:ok, Gleanex.Client.CreateAuthTokenResponse.t()} | {:error, Gleanex.Error.t()}
  def createauthtoken(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Gleanex.Client.Authentication, :createauthtoken},
      url: "/createauthtoken",
      method: :post,
      response: [
        {200, {Gleanex.Client.CreateAuthTokenResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end
end
