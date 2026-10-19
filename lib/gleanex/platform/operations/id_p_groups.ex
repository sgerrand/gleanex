defmodule Gleanex.Platform.IdPGroups do
  @moduledoc """
  Provides API endpoints related to id p groups
  """

  @default_client Gleanex.HTTP

  @doc """
  Get an IdP group

  Get one identity provider (IdP) group by its idp_group_id. Inactive IdP groups are returned, so a caller can still show a group after it was removed from the identity provider. An IdP group is active when Glean loaded it from the directory. An IdP group is inactive when only a usage limit names it, for example after the group was removed from the identity provider. An idp_group_id that is not valid, or that names no group that the list returns, returns 404 resource_not_found. The caller must be able to read the workspace configuration or the workspace billing.

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

  List the identity provider (IdP) groups that Glean loads from the directory, ordered by display_name and then by idp_group_id. Use idp_group_id to name a group in other Platform APIs. An IdP group is active when Glean loaded it from the directory. An IdP group is inactive when only a usage limit names it, for example after the group was removed from the identity provider. Inactive IdP groups are left out unless an is_active filter includes the value "false". Usage limits apply only to IdP groups from the datasource instance that the usage settings select, so use the provider_instance filter to list only those groups. Internal O365 ownership groups and SharePoint groups are left out. The caller must be able to read the workspace configuration or the workspace billing.

  ## Options

    * `page_size`: Maximum number of IdP groups to return. Defaults to 50. Maximum is 100.
    * `cursor`: Opaque pagination cursor from a previous response. Send the same filters that the previous request used.
      
    * `filters`: JSON-encoded filters that choose which IdP groups are returned. The supported fields are is_active, with the values "true" and "false", and provider_instance, with datasource instance names such as "okta". provider_instance values match without case. The only supported operator is EQUALS. Multiple values OR within a filter. Multiple filters AND together. Without an is_active filter, only active IdP groups are returned. To return active and inactive IdP groups, send [{"field":"is_active","values":["true","false"]}].
      

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
