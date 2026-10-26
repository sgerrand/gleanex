defmodule Gleanex.Platform.OAuthClients do
  @moduledoc """
  Provides API endpoints related to o auth clients
  """

  @default_client Gleanex.HTTP

  @doc """
  Get an OAuth client

  Get one static OAuth client that an admin created for this workspace. A client that an admin disabled is returned with is_active false. A deleted client, a dynamically registered client, one of Glean's own clients, such as Glean Desktop, and an unknown client_id all return 404. The path takes the OAuth client_id, not ai_gateway.usage_client_id. The caller needs admin read or billing read permission.

  """
  @spec admin_oauth_clients_get(client_id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.GetOAuthClientResponse.t()} | {:error, Gleanex.Error.t()}
  def admin_oauth_clients_get(client_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [client_id: client_id],
      call: {Gleanex.Platform.OAuthClients, :admin_oauth_clients_get},
      url: "/admin/oauth/clients/#{client_id}",
      method: :get,
      response: [
        {200, {Gleanex.Platform.GetOAuthClientResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List OAuth clients

  List the static OAuth clients that admins created for this workspace, ordered by display_name and then by client_id. Dynamically registered clients and Glean's own clients, such as Glean Desktop, are not listed. A client is active when it is enabled. Inactive clients are left out unless an is_active filter includes the value "false". To set a usage limit for a client, send its ai_gateway.usage_client_id, not its client_id, to the usage APIs. The caller needs admin read or billing read permission.

  ## Options

    * `page_size`: Maximum number of clients to return. Defaults to 50. Maximum is 100.
    * `cursor`: Opaque pagination cursor from a previous response. Send the same filters that the previous request used.
      
    * `filters`: JSON-encoded filters that choose which clients are returned. The only supported field is is_active, with the values "true" and "false" and the operator EQUALS. Multiple values OR within a filter. Multiple filters AND together. Without an is_active filter, only active clients are returned. To return active and inactive clients, send [{"field":"is_active","values":["true","false"]}].
      

  """
  @spec admin_oauth_clients_list(opts :: keyword) ::
          {:ok, Gleanex.Platform.ListOAuthClientsResponse.t()} | {:error, Gleanex.Error.t()}
  def admin_oauth_clients_list(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:cursor, :filters, :page_size])

    client.request(%{
      args: [],
      call: {Gleanex.Platform.OAuthClients, :admin_oauth_clients_list},
      url: "/admin/oauth/clients",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Platform.ListOAuthClientsResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end
end
