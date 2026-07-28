defmodule Gleanex.Client.Agents do
  @moduledoc """
  Provides API endpoints related to agents
  """

  @default_client Gleanex.HTTP

  @doc """
  Create an agent

  Create an agent.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.
    * `timezoneOffset`: The offset of the client's timezone in minutes from UTC. e.g. PDT is -420 because it's 7 hours behind UTC.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec create_agent(body :: Gleanex.Client.CreateWorkflowRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.CreateWorkflowResponse.t()} | {:error, Gleanex.Error.t()}
  def create_agent(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale, :timezoneOffset])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Agents, :create_agent},
      url: "/agents",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.CreateWorkflowRequest, :t}}],
      response: [
        {200, {Gleanex.Client.CreateWorkflowResponse, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {500, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Create an agent run and stream the response

  Executes an [agent](https://developers.glean.com/agents/agents-api) run and returns the result as a stream of server-sent events (SSE). **Note**: If the agent uses an input form trigger, all form fields (including optional fields) must be included in the `input` object.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec create_and_stream_run(body :: Gleanex.Client.AgentRunCreate.t(), opts :: keyword) ::
          {:ok, String.t()} | {:error, Gleanex.Error.t()}
  def create_and_stream_run(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Agents, :create_and_stream_run},
      url: "/agents/runs/stream",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Client.AgentRunCreate, :t}}],
      response: [
        {200, :string},
        {400, :null},
        {403, :null},
        {404, :string},
        {409, :string},
        {422, :string},
        {500, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Create an agent run and wait for the response

  Executes an [agent](https://developers.glean.com/agents/agents-api) run and returns the final response. **Note**: If the agent uses an input form trigger, all form fields (including optional fields) must be included in the `input` object.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec create_and_wait_run(body :: Gleanex.Client.AgentRunCreate.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.AgentRunWaitResponse.t()} | {:error, Gleanex.Error.t()}
  def create_and_wait_run(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Agents, :create_and_wait_run},
      url: "/agents/runs/wait",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Client.AgentRunCreate, :t}}],
      response: [
        {200, {Gleanex.Client.AgentRunWaitResponse, :t}},
        {400, :null},
        {403, :null},
        {404, :null},
        {409, :null},
        {422, :null},
        {500, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Edit an agent

  Creates a draft or publishes an [agent](https://developers.glean.com/agents/agents-api). Use `isDraft=true` to save a draft, or `isDraft=false` (or omit) to publish immediately. Only draft and publish modes are supported.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.
    * `timezoneOffset`: The offset of the client's timezone in minutes from UTC. e.g. PDT is -420 because it's 7 hours behind UTC.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec edit_agent(
          agent_id :: String.t(),
          body :: Gleanex.Client.EditWorkflowRequest.t(),
          opts :: keyword
        ) :: :ok | {:error, Gleanex.Error.t()}
  def edit_agent(agent_id, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale, :timezoneOffset])

    client.request(%{
      args: [agent_id: agent_id, body: body],
      call: {Gleanex.Client.Agents, :edit_agent},
      url: "/agents/#{agent_id}",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.EditWorkflowRequest, :t}}],
      response: [
        {200, :null},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :string},
        {500, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Retrieve an agent

  Returns details of an [agent](https://developers.glean.com/agents/agents-api) created in the Agent Builder.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.
    * `timezoneOffset`: The offset of the client's timezone in minutes from UTC. e.g. PDT is -420 because it's 7 hours behind UTC.

  """
  @spec get_agent(agent_id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.Agent.t()} | {:error, Gleanex.Error.t()}
  def get_agent(agent_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale, :timezoneOffset])

    client.request(%{
      args: [agent_id: agent_id],
      call: {Gleanex.Client.Agents, :get_agent},
      url: "/agents/#{agent_id}",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Client.Agent, :t}},
        {400, :null},
        {403, :null},
        {404, :string},
        {500, :null}
      ],
      opts: opts
    })
  end

  @doc """
  List an agent's schemas

  Return [agent](https://developers.glean.com/agents/agents-api)'s input and output schemas. You can use these schemas to detect changes to an agent's input or output structure.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.
    * `timezoneOffset`: The offset of the client's timezone in minutes from UTC. e.g. PDT is -420 because it's 7 hours behind UTC.

  """
  @spec get_agent_schemas(agent_id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.AgentSchemas.t()} | {:error, Gleanex.Error.t()}
  def get_agent_schemas(agent_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale, :timezoneOffset])

    client.request(%{
      args: [agent_id: agent_id],
      call: {Gleanex.Client.Agents, :get_agent_schemas},
      url: "/agents/#{agent_id}/schemas",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Client.AgentSchemas, :t}},
        {400, :null},
        {403, :null},
        {404, :string},
        {422, :string},
        {500, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Search agents

  Search for [agents](https://developers.glean.com/agents/agents-api) by agent name.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec search_agents(body :: Gleanex.Client.SearchAgentsRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.SearchAgentsResponse.t()} | {:error, Gleanex.Error.t()}
  def search_agents(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Agents, :search_agents},
      url: "/agents/search",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Client.SearchAgentsRequest, :t}}],
      response: [
        {200, {Gleanex.Client.SearchAgentsResponse, :t}},
        {400, :null},
        {403, :null},
        {404, :string},
        {422, :string},
        {500, :null}
      ],
      opts: opts
    })
  end
end
