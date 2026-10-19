defmodule Gleanex.Platform.AdminAgents do
  @moduledoc """
  Provides API endpoint related to admin agents
  """

  @default_client Gleanex.HTTP

  @doc """
  List all agents

  List every agent in the workspace, ordered by display_name and then by agent_id. Unlike agent search, the list does not depend on who an agent is shared with, so it includes private and disabled agents. Deleted agents are inactive and are left out unless an is_active filter includes the value "false". Use the agent_id of an active agent with other Platform APIs, for example as a usage limit target. A deleted agent is not a valid usage limit target. The caller must be able to read all agents, administer agents, or read workspace billing.

  ## Options

    * `page_size`: Maximum number of agents to return. Defaults to 50. Maximum is 100.
    * `cursor`: Opaque pagination cursor from a previous response. Send the same filters that the previous request used.
      
    * `filters`: JSON-encoded filters that choose which agents are returned. The only supported field is is_active, with the values "true" and "false" and the operator EQUALS. Multiple values OR within a filter. Multiple filters AND together. Without an is_active filter, only active agents are returned. To return active and deleted agents, send [{"field":"is_active","values":["true","false"]}].
      

  """
  @spec list(opts :: keyword) ::
          {:ok, Gleanex.Platform.ListAdminAgentsResponse.t()} | {:error, Gleanex.Error.t()}
  def list(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:cursor, :filters, :page_size])

    client.request(%{
      args: [],
      call: {Gleanex.Platform.AdminAgents, :list},
      url: "/admin/agents",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Platform.ListAdminAgentsResponse, :t}},
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
