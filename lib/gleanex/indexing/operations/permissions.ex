defmodule Gleanex.Indexing.Permissions do
  @moduledoc """
  Provides API endpoints related to permissions
  """

  @default_client Gleanex.HTTP

  @doc """
  Beta users

  Allow the datasource be visible to the specified beta users. The default behaviour is datasource being visible to all users if it is enabled and not visible to any user if it is not enabled.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec betausers(body :: Gleanex.Indexing.GreenlistUsersRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def betausers(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Permissions, :betausers},
      url: "/betausers",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.GreenlistUsersRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Bulk index groups

  Replaces the groups in a datasource using paginated batch API calls. Please refer to the [bulk indexing](https://developers.glean.com/indexing/documents/bulk-upload-model) documentation for an explanation of how to use bulk endpoints.
  Note: Any groups deleted from the existing set will have their associated memberships deleted as well.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec bulkindexgroups(body :: Gleanex.Indexing.BulkIndexGroupsRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def bulkindexgroups(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Permissions, :bulkindexgroups},
      url: "/bulkindexgroups",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.BulkIndexGroupsRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Bulk index memberships for a group

  Replaces the memberships for a group in a datasource using paginated batch API calls. Please refer to the [bulk indexing](https://developers.glean.com/indexing/documents/bulk-upload-model) documentation for an explanation of how to use bulk endpoints.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec bulkindexmemberships(
          body :: Gleanex.Indexing.BulkIndexMembershipsRequest.t(),
          opts :: keyword
        ) :: :ok | {:error, Gleanex.Error.t()}
  def bulkindexmemberships(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Permissions, :bulkindexmemberships},
      url: "/bulkindexmemberships",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.BulkIndexMembershipsRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Bulk index users

  Replaces the users in a datasource using paginated batch API calls. Please refer to the [bulk indexing](https://developers.glean.com/indexing/documents/bulk-upload-model) documentation for an explanation of how to use bulk endpoints.
  Note: Any users deleted from the existing set will have their associated memberships deleted as well.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec bulkindexusers(body :: Gleanex.Indexing.BulkIndexUsersRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def bulkindexusers(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Permissions, :bulkindexusers},
      url: "/bulkindexusers",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.BulkIndexUsersRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Delete group

  Delete group from the datasource. Silently succeeds if group is not present.
  Note: All memberships associated with the deleted group will also be deleted.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec deletegroup(body :: Gleanex.Indexing.DeleteGroupRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def deletegroup(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Permissions, :deletegroup},
      url: "/deletegroup",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.DeleteGroupRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Delete membership

  Delete membership to a group in the specified datasource. Silently succeeds if membership is not present.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec deletemembership(body :: Gleanex.Indexing.DeleteMembershipRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def deletemembership(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Permissions, :deletemembership},
      url: "/deletemembership",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.DeleteMembershipRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Delete user

  Delete the user from the datasource. Silently succeeds if user is not present.
  Note: All memberships associated with the deleted user will also be deleted.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec deleteuser(body :: Gleanex.Indexing.DeleteUserRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def deleteuser(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Permissions, :deleteuser},
      url: "/deleteuser",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.DeleteUserRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Index group

  Add or update a group in the datasource.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec indexgroup(body :: Gleanex.Indexing.IndexGroupRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def indexgroup(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Permissions, :indexgroup},
      url: "/indexgroup",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.IndexGroupRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Index membership

  Add the memberships of a group in the datasource.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec indexmembership(body :: Gleanex.Indexing.IndexMembershipRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def indexmembership(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Permissions, :indexmembership},
      url: "/indexmembership",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.IndexMembershipRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Index user

  Adds a datasource user or updates an existing user.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec indexuser(body :: Gleanex.Indexing.IndexUserRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def indexuser(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Permissions, :indexuser},
      url: "/indexuser",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.IndexUserRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Schedules the processing of group memberships

  Schedules the immediate processing of all group memberships uploaded through the indexing API. By default the uploaded group memberships will be processed asynchronously but this API can be used to schedule processing of all memberships on demand.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec processallmemberships(
          body :: Gleanex.Indexing.ProcessAllMembershipsRequest.t(),
          opts :: keyword
        ) :: :ok | {:error, Gleanex.Error.t()}
  def processallmemberships(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Permissions, :processallmemberships},
      url: "/processallmemberships",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.ProcessAllMembershipsRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}],
      opts: opts
    })
  end
end
