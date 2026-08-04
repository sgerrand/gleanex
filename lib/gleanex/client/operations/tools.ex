defmodule Gleanex.Client.Tools do
  @moduledoc """
  Provides API endpoints related to tools
  """

  @default_client Gleanex.HTTP

  @doc """
  Start the OAuth authorization flow for an action pack.

  Starts the third-party OAuth flow for the specified action pack and returns the
  redirect URL that the client should navigate the end user to. After the OAuth
  callback completes, the user's browser is redirected back to `returnUrl` with a
  status query parameter (`?glean_action_auth=success|error&actionPackId=...`).

  `returnUrl` must match the tenant's configured return URL allowlist; otherwise the
  request is rejected with 400.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec authorize_action_pack(
          actionPackId :: String.t(),
          body :: Gleanex.Client.AuthorizeActionPackRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Client.AuthorizeActionPackResponse.t()} | {:error, Gleanex.Error.t()}
  def authorize_action_pack(actionPackId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actionPackId: actionPackId, body: body],
      call: {Gleanex.Client.Tools, :authorize_action_pack},
      url: "/actions/actionpack/#{actionPackId}/auth",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Client.AuthorizeActionPackRequest, :t}}],
      response: [
        {200, {Gleanex.Client.AuthorizeActionPackResponse, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Start the OAuth authorization flow for a tool server.

  Initiates the third-party OAuth flow for the specified tool server and returns the
  authorization URL that the client should navigate the end user to. After the OAuth
  callback completes, the user's browser is redirected back to `returnUrl` with query
  parameters indicating the result.

  `returnUrl` must match the tenant's configured return URL allowlist; otherwise the
  request is rejected with 400.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec authorize_tool_server(
          serverId :: String.t(),
          body :: Gleanex.Client.AuthorizeToolServerRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Client.AuthorizeToolServerResponse.t()} | {:error, Gleanex.Error.t()}
  def authorize_tool_server(serverId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [serverId: serverId, body: body],
      call: {Gleanex.Client.Tools, :authorize_tool_server},
      url: "/tool-servers/#{serverId}/auth",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Client.AuthorizeToolServerRequest, :t}}],
      response: [
        {200, {Gleanex.Client.AuthorizeToolServerResponse, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get end-user authentication status for an action pack.

  Reports whether the calling user is already authenticated against the third-party
  tool backing the specified action pack. Intended for headless / server-driven clients
  that render an "Authorize" prompt when the user has not yet consented to the tool.

  """
  @spec get_action_pack_auth_status(actionPackId :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.ActionPackAuthStatusResponse.t()} | {:error, Gleanex.Error.t()}
  def get_action_pack_auth_status(actionPackId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actionPackId: actionPackId],
      call: {Gleanex.Client.Tools, :get_action_pack_auth_status},
      url: "/actions/actionpack/#{actionPackId}/auth",
      method: :get,
      response: [
        {200, {Gleanex.Client.ActionPackAuthStatusResponse, :t}},
        {400, :null},
        {401, :null},
        {404, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get end-user authentication status for a tool server.

  Returns display information and the calling user's current authentication status
  for the specified tool server.

  """
  @spec get_tool_server_auth_status(serverId :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.ToolServerAuthStatusResponse.t()} | {:error, Gleanex.Error.t()}
  def get_tool_server_auth_status(serverId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [serverId: serverId],
      call: {Gleanex.Client.Tools, :get_tool_server_auth_status},
      url: "/tool-servers/#{serverId}/auth",
      method: :get,
      response: [
        {200, {Gleanex.Client.ToolServerAuthStatusResponse, :t}},
        {400, :null},
        {401, :null},
        {404, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get tool definitions from a tool server.

  Returns the name, description and JSON input schema for the named tools on the
  specified tool server. Works for both action packs and MCP servers.

  `toolNames` is required. Names that do not exist on the server are returned in
  `notFound` rather than failing the request, so a single bad name does not force
  callers into one-at-a-time retries. Matching is case-insensitive and treats `-`
  and `_` as equivalent.

  Native tools are not served; `serverId=native` returns 404.

  ## Options

    * `toolNames`: Tool names to look up on this server. Maximum 100.

  """
  @spec get_tool_server_tools(serverId :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.ToolDefinitionsResponse.t()} | {:error, Gleanex.Error.t()}
  def get_tool_server_tools(serverId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:toolNames])

    client.request(%{
      args: [serverId: serverId],
      call: {Gleanex.Client.Tools, :get_tool_server_tools},
      url: "/tool-servers/#{serverId}/tools",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Client.ToolDefinitionsResponse, :t}},
        {400, :null},
        {401, :null},
        {404, :null},
        {429, :null},
        {503, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Execute the specified tool

  Execute the specified tool with provided parameters

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec tools_call(body :: Gleanex.Client.ToolsCallRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.ToolsCallResponse.t()} | {:error, Gleanex.Error.t()}
  def tools_call(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Tools, :tools_call},
      url: "/tools/call",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Client.ToolsCallRequest, :t}}],
      response: [
        {200, {Gleanex.Client.ToolsCallResponse, :t}},
        {400, :null},
        {401, :null},
        {404, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  List available tools

  Returns a filtered set of available tools based on optional tool name parameters. If no filters are provided, all available tools are returned.

  ## Options

    * `toolNames`: Optional array of tool names to filter by

  """
  @spec tools_list_get(opts :: keyword) ::
          {:ok, Gleanex.Client.ToolsListResponse.t()} | {:error, Gleanex.Error.t()}
  def tools_list_get(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:toolNames])

    client.request(%{
      args: [],
      call: {Gleanex.Client.Tools, :tools_list_get},
      url: "/tools/list",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Client.ToolsListResponse, :t}},
        {400, :null},
        {401, :null},
        {404, :null},
        {429, :null}
      ],
      opts: opts
    })
  end
end
