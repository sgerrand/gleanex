defmodule Gleanex.Platform.Agents do
  @moduledoc """
  Provides API endpoints related to agents
  """

  @default_client Gleanex.HTTP

  @doc """
  Create agent run

  Execute an agent run. Set `stream` to true to receive server-sent events; otherwise the response contains the final agent messages.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec create_run(
          agent_id :: String.t(),
          body :: Gleanex.Platform.AgentRunCreateRequest.t(),
          opts :: keyword
        ) ::
          {:ok, Gleanex.Platform.AgentRunWaitResponse.t() | String.t()}
          | {:error, Gleanex.Error.t()}
  def create_run(agent_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [agent_id: agent_id, body: body],
      call: {Gleanex.Platform.Agents, :create_run},
      url: "/agents/#{agent_id}/runs",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Platform.AgentRunCreateRequest, :t}}],
      response: [
        {200, {:union, [:string, {Gleanex.Platform.AgentRunWaitResponse, :t}]}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {409, {Gleanex.Platform.ProblemDetail, :t}},
        {413, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get agent

  Retrieve details for an agent available to the authenticated user.

  """
  @spec get(agent_id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.AgentGetResponse.t()} | {:error, Gleanex.Error.t()}
  def get(agent_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [agent_id: agent_id],
      call: {Gleanex.Platform.Agents, :get},
      url: "/agents/#{agent_id}",
      method: :get,
      response: [
        {200, {Gleanex.Platform.AgentGetResponse, :t}},
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
  Get agent schemas

  Retrieve an agent's input and output JSON schemas.

  ## Options

    * `include_tools`: Whether to include tool metadata in the response.

  """
  @spec get_schemas(agent_id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.AgentSchemasResponse.t()} | {:error, Gleanex.Error.t()}
  def get_schemas(agent_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:include_tools])

    client.request(%{
      args: [agent_id: agent_id],
      call: {Gleanex.Platform.Agents, :get_schemas},
      url: "/agents/#{agent_id}/schemas",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Platform.AgentSchemasResponse, :t}},
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
  Search agents

  Search agents available to the authenticated user by agent name.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec search(body :: Gleanex.Platform.AgentsSearchRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.AgentsSearchResponse.t()} | {:error, Gleanex.Error.t()}
  def search(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.Agents, :search},
      url: "/agents/search",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Platform.AgentsSearchRequest, :t}}],
      response: [
        {200, {Gleanex.Platform.AgentsSearchResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {413, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end
end
