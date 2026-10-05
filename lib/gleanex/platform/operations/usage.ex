defmodule Gleanex.Platform.Usage do
  @moduledoc """
  Provides API endpoints related to usage
  """

  @default_client Gleanex.HTTP

  @doc """
  Apply usage limit policies

  Apply one or more usage limit policy changes atomically. This action sets policy by natural key; it does not create addressable resources or return resource locations. Every change succeeds or none are applied. USER targets may be identified by user_id or email; each resolves to the canonical user_id before duplicate natural keys are checked. Requires admin.usage.limits:write and permission to edit workspace billing.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec admin_usage_limits_batch(body :: [Gleanex.Platform.UsageLimit.t()], opts :: keyword) ::
          {:ok, Gleanex.Platform.BatchUsageLimitsResponse.t()} | {:error, Gleanex.Error.t()}
  def admin_usage_limits_batch(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.Usage, :admin_usage_limits_batch},
      url: "/admin/usage/limits/batch",
      body: body,
      method: :post,
      request: [{"application/json", [{Gleanex.Platform.UsageLimit, :t}]}],
      response: [
        {200, {Gleanex.Platform.BatchUsageLimitsResponse, :t}},
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

  @doc """
  Evaluate administrative usage limit headroom

  Evaluate the effective usage limits for a selector and return the current decision (AVAILABLE, WARNING, or BLOCKED) based on accrued usage. Requires admin.usage:evaluate and permission to read workspace billing, not a global administrator role. An explicit usage_selector.client_id selects the Glean or external spend client; it is never inferred from the caller. Returns all applicable limit values and counters, with effective headroom separated by unit. Agent counters retain aggregate scope. Billing readers receive exact IdP-group source identities. A USER target may be identified by user_id or email. Evaluation reports configured-budget status even when runtime enforcement switches are off; it does not perform request admission, model eligibility, or agent-run preflight checks.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec admin_usage_limits_evaluate(
          body :: Gleanex.Platform.EvaluateUsageLimitRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Platform.EvaluateUsageLimitResponse.t()} | {:error, Gleanex.Error.t()}
  def admin_usage_limits_evaluate(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.Usage, :admin_usage_limits_evaluate},
      url: "/admin/usage/limits/evaluate",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Platform.EvaluateUsageLimitRequest, :t}}],
      response: [
        {200, {Gleanex.Platform.EvaluateUsageLimitResponse, :t}},
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

  @doc """
  List usage limits

  List configured limits across Glean and external spend clients, plus aggregate agent limits. Organization and user limits identify their spend client; aggregate agent limits omit client_id. USER targets return the canonical user_id and, when available, the user's directory email. Requires admin.usage.limits:read and permission to read workspace billing.

  ## Options

    * `page_size`: Maximum number of limits to return. Defaults to 20; the maximum allowed is 100.
    * `cursor`: Opaque cursor from a previous list response.

  """
  @spec admin_usage_limits_list(opts :: keyword) ::
          {:ok, Gleanex.Platform.ListUsageLimitsResponse.t()} | {:error, Gleanex.Error.t()}
  def admin_usage_limits_list(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:cursor, :page_size])

    client.request(%{
      args: [],
      call: {Gleanex.Platform.Usage, :admin_usage_limits_list},
      url: "/admin/usage/limits",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Platform.ListUsageLimitsResponse, :t}},
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
  Reset a usage limit

  Remove a configured usage limit matching the selector without clearing measured usage. A USER target may be identified by user_id or email, including a user no longer in the directory. Requires admin.usage.limits:write and permission to edit workspace billing.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec admin_usage_limits_reset(body :: Gleanex.Platform.UsageLimitKey.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.ResetUsageLimitsResponse.t()} | {:error, Gleanex.Error.t()}
  def admin_usage_limits_reset(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.Usage, :admin_usage_limits_reset},
      url: "/admin/usage/limits/reset",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Platform.UsageLimitKey, :t}}],
      response: [
        {200, {Gleanex.Platform.ResetUsageLimitsResponse, :t}},
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

  @doc """
  Upsert a usage limit

  Create or replace a single usage limit by its natural key. Always returns 200 with the normalized limit. A USER target may be identified by user_id or email; an unknown user returns 404. Requires admin.usage.limits:write and permission to edit workspace billing. Personal usage grants do not allow limit changes.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec admin_usage_limits_upsert(body :: Gleanex.Platform.UsageLimit.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.UpsertUsageLimitResponse.t()} | {:error, Gleanex.Error.t()}
  def admin_usage_limits_upsert(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.Usage, :admin_usage_limits_upsert},
      url: "/admin/usage/limits",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Platform.UsageLimit, :t}}],
      response: [
        {200, {Gleanex.Platform.UpsertUsageLimitResponse, :t}},
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

  @doc """
  Submit an editable-agent limit-increase request

  Requires usage.limit_increase_requests:write, the same scope as personal creation, and current edit permission on the agent, not billing permissions. The caller supplies the agent, client, and optional business justification. Requester identity comes from authentication; the server assigns the request identifier and current UTC month. This internal scaffold returns 503 without creating a request.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec admin_usage_requests_create(
          body :: Gleanex.Platform.AgentRequestCreate.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Platform.RequestResponse.t()} | {:error, Gleanex.Error.t()}
  def admin_usage_requests_create(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.Usage, :admin_usage_requests_create},
      url: "/admin/usage/limit-increase-requests",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Platform.AgentRequestCreate, :t}}],
      response: [
        {201, {Gleanex.Platform.RequestResponse, :t}},
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
  Get a billing limit-increase request

  Requires admin.usage.limit_increase_requests:read. Authorization precedes resource disclosure. This internal scaffold returns 503 without reading the request.

  """
  @spec admin_usage_requests_get(request_id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.RequestResponse.t()} | {:error, Gleanex.Error.t()}
  def admin_usage_requests_get(request_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [request_id: request_id],
      call: {Gleanex.Platform.Usage, :admin_usage_requests_get},
      url: "/admin/usage/limit-increase-requests/#{request_id}",
      method: :get,
      response: [
        {200, {Gleanex.Platform.RequestResponse, :t}},
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
  List the billing limit-increase request queue

  Requires admin.usage.limit_increase_requests:read and current workspace billing read permission. Agent ownership is not queue access. Cursors bind filters and current authorization context. This internal scaffold returns 503, not a successful empty page.

  ## Options

    * `page_size`: Maximum page size; defaults to 20 and cannot exceed 100. A page may contain fewer results.
    * `cursor`: Opaque cursor bound to filter fields, values, operators, and current authorization context.
    * `filters`: JSON-encoded filters. Only the field status and operator EQUALS are supported. Multiple values OR within a filter. Multiple filters AND together. Cursors bind all filter fields, values, and operators.
      

  """
  @spec admin_usage_requests_list(opts :: keyword) ::
          {:ok, Gleanex.Platform.RequestListResponse.t()} | {:error, Gleanex.Error.t()}
  def admin_usage_requests_list(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:cursor, :filters, :page_size])

    client.request(%{
      args: [],
      call: {Gleanex.Platform.Usage, :admin_usage_requests_list},
      url: "/admin/usage/limit-increase-requests",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Platform.RequestListResponse, :t}},
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
  Resolve a billing limit-increase request

  Update a pending request with an approval decision or denial. Requires admin.usage.limit_increase_requests:write and current billing edit permission. A pending request can be approved with a positive additive increase or denied with an optional resolution note. PERIOD applies to the request's stored month; ONGOING increases the applicable standing rule at the selected resolution target. Ongoing approval is supported only for user requests, not agent requests. This internal scaffold returns 503 without resolving requests or changing policy.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec admin_usage_requests_update(
          request_id :: String.t(),
          body :: Gleanex.Platform.AdministrativeRequestUpdate.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Platform.RequestResponse.t()} | {:error, Gleanex.Error.t()}
  def admin_usage_requests_update(request_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [request_id: request_id, body: body],
      call: {Gleanex.Platform.Usage, :admin_usage_requests_update},
      url: "/admin/usage/limit-increase-requests/#{request_id}",
      body: body,
      method: :patch,
      request: [{"application/json", {Gleanex.Platform.AdministrativeRequestUpdate, :t}}],
      response: [
        {200, {Gleanex.Platform.RequestResponse, :t}},
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
  Get usage settings

  Retrieve workspace-wide usage settings. Requires admin.usage.settings:read and permission to read workspace billing; a global administrator role is not required.

  """
  @spec admin_usage_settings_get(opts :: keyword) ::
          {:ok, Gleanex.Platform.UsageSettingsResponse.t()} | {:error, Gleanex.Error.t()}
  def admin_usage_settings_get(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Gleanex.Platform.Usage, :admin_usage_settings_get},
      url: "/admin/usage/settings",
      method: :get,
      response: [
        {200, {Gleanex.Platform.UsageSettingsResponse, :t}},
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
  Update usage settings

  Partially update workspace-wide usage settings. Requires admin.usage.settings:write and permission to edit workspace billing; a global administrator role is not required.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec admin_usage_settings_update(body :: map, opts :: keyword) ::
          {:ok, Gleanex.Platform.UsageSettingsResponse.t()} | {:error, Gleanex.Error.t()}
  def admin_usage_settings_update(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.Usage, :admin_usage_settings_update},
      url: "/admin/usage/settings",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {Gleanex.Platform.UsageSettingsResponse, :t}},
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

  @doc """
  Evaluate usage limit headroom

  Evaluate the effective usage limits for a selector and return the current decision (AVAILABLE, WARNING, or BLOCKED) based on accrued usage. Requires usage:evaluate, without workspace billing permission. Omit target to evaluate the authenticated canonical user. An explicit USER must identify that user by canonical ID, known alias ID, email, or known alias email; every supplied field must identify the caller. An explicit AGENT requires current owner/editor or applicable global agent-edit permission; disabled agents remain eligible. Subagents, other users, ORGANIZATION, and default targets are forbidden on this route, even for billing administrators. Missing, inaccessible, and subagent targets return the same 403 insufficient_permissions. An explicit usage_selector.client_id selects the Glean or external spend client; it is never inferred from the caller. Agent evaluation reports aggregate agent usage and the selected client's organization limit, not the caller's personal slice or a complete run preflight. All applicable limit values, used counters, decisions, and headroom are returned; USD and credits have separate effective_limits. IdP-group source identities require billing-read permission. Other callers receive an IDP_GROUP source with is_identity_restricted true and no group_id, without suppressing the policy's value, counter, or decision. Evaluation reports configured-budget status even when runtime enforcement switches are off; it does not perform request admission, model eligibility, or agent-run preflight checks.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec limits_evaluate(
          body :: Gleanex.Platform.EvaluateCallerUsageLimitRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Platform.EvaluateUsageLimitResponse.t()} | {:error, Gleanex.Error.t()}
  def limits_evaluate(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.Usage, :limits_evaluate},
      url: "/usage/limits/evaluate",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Platform.EvaluateCallerUsageLimitRequest, :t}}],
      response: [
        {200, {Gleanex.Platform.EvaluateUsageLimitResponse, :t}},
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

  @doc """
  Submit a personal limit-increase request

  Requires usage.limit_increase_requests:write. The target is the authenticated canonical user, and requester identity comes from authentication. The caller supplies the client and optional business justification. The server assigns the request identifier and current UTC month. Billing grants do not widen this route. This internal scaffold returns 503 without creating a request.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec requests_create(body :: Gleanex.Platform.PersonalRequestCreate.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.RequestResponse.t()} | {:error, Gleanex.Error.t()}
  def requests_create(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.Usage, :requests_create},
      url: "/usage/limit-increase-requests",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Platform.PersonalRequestCreate, :t}}],
      response: [
        {201, {Gleanex.Platform.RequestResponse, :t}},
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
  Get a personal limit-increase request

  Requires usage.limit_increase_requests:read and the current user's request. Authorization precedes resource disclosure. This internal scaffold returns 503 without reading the request.

  """
  @spec requests_get(request_id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.RequestResponse.t()} | {:error, Gleanex.Error.t()}
  def requests_get(request_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [request_id: request_id],
      call: {Gleanex.Platform.Usage, :requests_get},
      url: "/usage/limit-increase-requests/#{request_id}",
      method: :get,
      response: [
        {200, {Gleanex.Platform.RequestResponse, :t}},
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
  List personal limit-increase requests

  Requires usage.limit_increase_requests:read. The collection is limited to the authenticated canonical user's requests, including resolved requests. Cursors bind the filters and current authorization context; a billing grant cannot widen results. This internal scaffold returns 503 without reading requests.

  ## Options

    * `page_size`: Maximum page size; defaults to 20 and cannot exceed 100. A page may contain fewer results.
    * `cursor`: Opaque cursor bound to filter fields, values, operators, and current authorization context.
    * `filters`: JSON-encoded filters. Only the field status and operator EQUALS are supported. Multiple values OR within a filter. Multiple filters AND together. Cursors bind all filter fields, values, and operators.
      

  """
  @spec requests_list(opts :: keyword) ::
          {:ok, Gleanex.Platform.RequestListResponse.t()} | {:error, Gleanex.Error.t()}
  def requests_list(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:cursor, :filters, :page_size])

    client.request(%{
      args: [],
      call: {Gleanex.Platform.Usage, :requests_list},
      url: "/usage/limit-increase-requests",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Platform.RequestListResponse, :t}},
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
