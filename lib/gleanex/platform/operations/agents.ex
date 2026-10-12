defmodule Gleanex.Platform.Agents do
  @moduledoc """
  Provides API endpoints related to agents
  """

  @default_client Gleanex.HTTP

  @doc """
  Cancel an agent run

  Request cooperative cancellation of the durable agent run identified by `run_id` in the JSON body. Requires ownership, current agent access, and the agents.run scope. Sending a cancellation signal does not itself change an active run from RUNNING; poll GET run for the final state. Paused runs become CANCELLED without resuming execution. Repeated requests and requests for terminal runs return the current snapshot. Completion may win a race with cancellation. Completed tool side effects cannot be undone, and external work may continue if a tool does not support cancellation. Cancellation targets this run, not separate background-subagent executions. An active run without a cancellation registration returns 409. Cancellation signaling requires Redis. An interrupted active run can instead become FAILED through deadline cleanup; this does not verify that external tool work has stopped.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec cancel_run(
          agent_id :: String.t(),
          body :: Gleanex.Platform.AgentRunCancellationRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Platform.AgentRunResponse.t()} | {:error, Gleanex.Error.t()}
  def cancel_run(agent_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [agent_id: agent_id, body: body],
      call: {Gleanex.Platform.Agents, :cancel_run},
      url: "/agents/#{agent_id}/cancellations",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Platform.AgentRunCancellationRequest, :t}}],
      response: [
        {200, {Gleanex.Platform.AgentRunResponse, :t}},
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
  Create agent run

  Execute an agent run. By default, set `stream` to true to receive server-sent events; otherwise the response contains the final agent messages. Set `execution_mode` to `DURABLE` to persist a new run and return its initial snapshot with HTTP 201 without waiting for execution. Poll the agent-scoped GET run endpoint for progress. Durable execution continues after an HTTP disconnect, but is not automatically resumed after a QE restart or crash. An active turn becomes overdue more than 40 minutes after acceptance (a 30-minute execution timeout plus 10 minutes of grace). The next GET of the run marks the overdue turn FAILED without replay; there is no periodic sweep. Without a GET, the stored run can remain RUNNING. Failure does not prove that external tool work has stopped. Paused runs are not expired; an accepted approval continuation starts a fresh deadline. Each POST creates a new run; retrying a POST can create another execution. Submit pending approval decisions through the run responses endpoint, and cancellation can be requested through the run cancellations endpoint. A run tracks one workflow execution; automatic background-subagent wake turns are separate executions, not continuations tracked by this run ID.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec create_run(
          agent_id :: String.t(),
          body :: Gleanex.Platform.AgentRunCreateRequest.t(),
          opts :: keyword
        ) ::
          {:ok,
           Gleanex.Platform.AgentRunResponse.t()
           | Gleanex.Platform.AgentRunWaitResponse.t()
           | String.t()}
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
        {201, {Gleanex.Platform.AgentRunResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {409, {Gleanex.Platform.ProblemDetail, :t}},
        {413, {Gleanex.Platform.ProblemDetail, :t}},
        {422, {Gleanex.Platform.UnauthorizedAgentToolsProblem, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Respond to agent run approvals

  Submit decisions for every pending tool approval in the paused run's current batch. The run is identified by `run_id` in the JSON body. Decisions apply only to the stored invocations and arguments; argument edits, authentication responses, and session-wide grants are not supported. The caller must own the run, still have agent access, and have the agents.run scope. Acceptance persists the decisions before resuming the same run and chat session. Identical accepted decisions return the current snapshot without another continuation. Conflicting, stale, incomplete, or non-pending decisions return 409. Cancellation registration failure returns 503 without accepting the decisions; retry the same approval batch. This retry guarantee does not cover an indeterminate database commit outcome. Go workflow approval resumes currently support one tool invocation and one approval response. Unsupported multi-tool or multi-decision Go resumes fail without executing tools. The resumed action must resolve to the tool identified by the stored approval request and paused checkpoint. Missing or inconsistent identity fails without executing tools. Execution continues after HTTP disconnects, but is not automatically resumed after a QE crash. Each accepted continuation starts a fresh 30-minute execution timeout and 40-minute cleanup deadline. Identical retries do not extend that deadline. Waiting for approval does not expire a run. The next GET marks an overdue active turn FAILED without replaying execution.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec create_run_responses(
          agent_id :: String.t(),
          body :: Gleanex.Platform.AgentRunResponsesRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Platform.AgentRunResponse.t()} | {:error, Gleanex.Error.t()}
  def create_run_responses(agent_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [agent_id: agent_id, body: body],
      call: {Gleanex.Platform.Agents, :create_run_responses},
      url: "/agents/#{agent_id}/responses",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Platform.AgentRunResponsesRequest, :t}}],
      response: [
        {200, {Gleanex.Platform.AgentRunResponse, :t}},
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
  Get agent run

  Retrieve a persisted workflow execution owned by the authenticated user. The run must belong to the specified agent, and the user must still have access to that agent. Unknown runs, runs owned by another user, and mismatched agent/run identifiers return 404. Requires the agents.run scope. Executions without a persisted workflow record are not available through this endpoint.

  """
  @spec get_run(agent_id :: String.t(), run_id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.AgentRunResponse.t()} | {:error, Gleanex.Error.t()}
  def get_run(agent_id, run_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [agent_id: agent_id, run_id: run_id],
      call: {Gleanex.Platform.Agents, :get_run},
      url: "/agents/#{agent_id}/runs/#{run_id}",
      method: :get,
      response: [
        {200, {Gleanex.Platform.AgentRunResponse, :t}},
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
