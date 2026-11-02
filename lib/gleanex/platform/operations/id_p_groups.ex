defmodule Gleanex.Platform.IdPGroups do
  @moduledoc """
  Provides API endpoints related to id p groups
  """

  @default_client Gleanex.HTTP

  @doc """
  Get an IdP group

  Get one identity provider (IdP) group by its idp_group_id. An idp_group_id that is not valid, or that names no group that the list returns, returns 404 resource_not_found. A group that was removed from the identity provider returns 404 after Glean reloads the directory. The caller must be able to read the workspace configuration or the workspace billing.

  """
  @spec admin_idp_groups_get(idp_group_id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.GetIdpGroupResponse.t()} | {:error, Gleanex.Error.t()}
  def admin_idp_groups_get(idp_group_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [idp_group_id: idp_group_id],
      call: {Gleanex.Platform.IdPGroups, :admin_idp_groups_get},
      url: "/admin/idp-groups/#{idp_group_id}",
      method: :get,
      response: [
        {200, {Gleanex.Platform.GetIdpGroupResponse, :t}},
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
  List IdP groups

  List the identity provider (IdP) groups that Glean loads from the directory, ordered by display_name and then by idp_group_id. Use idp_group_id to name a group in other Platform APIs, such as the usage limit evaluation and limit increase request APIs. Usage limits apply only to IdP groups from the datasource instance in usage_settings.user_grouping.idp_group_provider_instance of the get usage settings response, and this API always lists that instance's groups. To list only those groups, pass that value in a provider_instance filter of the filters parameter, for example `filters=[{"field":"provider_instance","operator":"EQUALS","values":["okta"]}]`, URL-encoded as `filters=%5B%7B%22field%22%3A%22provider_instance%22%2C%22operator%22%3A%22EQUALS%22%2C%22values%22%3A%5B%22okta%22%5D%7D%5D`. Send a provider filter to list only one provider's groups, and a name filter to list only the groups whose display_name contains a value. Internal O365 ownership groups and SharePoint groups are left out. The caller must be able to read the workspace configuration or the workspace billing.

  ## Options

    * `page_size`: Maximum number of IdP groups to return. Defaults to 50. Maximum is 100.
    * `cursor`: Opaque pagination cursor from a previous response. Send the same filters that the previous request used.
      
    * `filters`: JSON-encoded filters that choose which IdP groups are returned. The supported fields are provider_instance, provider, and name. The only supported operator is EQUALS. Multiple values OR within a filter. Multiple filters AND together. The name field may appear in only one filter. A value that matches no IdP group returns no IdP groups rather than an error.
      

  """
  @spec admin_idp_groups_list(opts :: keyword) ::
          {:ok, Gleanex.Platform.ListIdpGroupsResponse.t()} | {:error, Gleanex.Error.t()}
  def admin_idp_groups_list(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:cursor, :filters, :page_size])

    client.request(%{
      args: [],
      call: {Gleanex.Platform.IdPGroups, :admin_idp_groups_list},
      url: "/admin/idp-groups",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Platform.ListIdpGroupsResponse, :t}},
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
