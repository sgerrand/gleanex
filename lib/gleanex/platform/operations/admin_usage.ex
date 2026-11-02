defmodule Gleanex.Platform.AdminUsage do
  @moduledoc """
  Provides API endpoints related to admin usage
  """

  @default_client Gleanex.HTTP

  @doc """
  Apply usage limit policies

  Apply one or more usage limit policy changes atomically. This action sets policy by natural key; it does not create addressable resources or return resource locations. Every change succeeds or none are applied. USER targets may be identified by user_id or email; each resolves to the canonical user_id before duplicate natural keys are checked. Requires admin.usage.limits:write and permission to edit workspace billing.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec limits_batch(body :: [Gleanex.Platform.UsageLimit.t()], opts :: keyword) ::
          {:ok, Gleanex.Platform.BatchUsageLimitsResponse.t()} | {:error, Gleanex.Error.t()}
  def limits_batch(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.AdminUsage, :limits_batch},
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

  Evaluate the effective usage limits for a selector and return the current decision (AVAILABLE, WARNING, or BLOCKED) based on accrued usage. Requires admin.usage:evaluate and permission to read workspace billing, not a global administrator role. An explicit usage_selector.client_id selects the Glean or external spend client; it is never inferred from the caller. Returns all applicable limit values and counters, with effective headroom separated by unit. Agent counters retain aggregate scope. Billing readers receive exact IdP-group source identities as idp_group_id values. A USER target may be identified by user_id or email. Evaluation reports configured-budget status even when runtime enforcement switches are off; it does not perform request admission, model eligibility, or agent-run preflight checks.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec limits_evaluate(body :: Gleanex.Platform.EvaluateUsageLimitRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.EvaluateUsageLimitResponse.t()} | {:error, Gleanex.Error.t()}
  def limits_evaluate(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.AdminUsage, :limits_evaluate},
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

  List configured limits across Glean and external spend clients, plus aggregate agent limits. Organization and user limits identify their spend client; aggregate agent limits omit client_id. USER targets return the canonical user_id and, when available, the user's directory email. Requires admin.usage.limits:read and permission to read workspace billing. Optional filters match configured limits. Pages contain up to page_size matching results; the service continues scanning until the page is full or the collection is exhausted. Continue with next_cursor while has_more is true, keeping the same filters on every continuation request. The undeclared client_id and target_type query parameters are rejected; use the canonical filters parameter instead.

  ## Options

    * `page_size`: Maximum number of limits to return. Defaults to 20; the maximum allowed is 100.
    * `cursor`: Opaque cursor from a previous list response; resend the same filters when continuing.
    * `filters`: JSON-encoded array of filters. Supported fields are client_id and target_type; only EQUALS is supported and is the default operator. Values within a filter are OR'd; filters are AND'd, including repeated fields. Client IDs are opaque, case-sensitive strings, matched exactly without trimming; whitespace-only values are invalid. Client filters include organization, default-user, and user policies, but exclude aggregate agent policies without a client_id. target_type values are ORGANIZATION, DEFAULT_USER, USER, DEFAULT_AGENT, and AGENT. URL-encode the JSON array as one filters query value.
      

  """
  @spec limits_list(opts :: keyword) ::
          {:ok, Gleanex.Platform.ListUsageLimitsResponse.t()} | {:error, Gleanex.Error.t()}
  def limits_list(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:cursor, :filters, :page_size])

    client.request(%{
      args: [],
      call: {Gleanex.Platform.AdminUsage, :limits_list},
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
  @spec limits_reset(body :: Gleanex.Platform.UsageLimitKey.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.ResetUsageLimitsResponse.t()} | {:error, Gleanex.Error.t()}
  def limits_reset(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.AdminUsage, :limits_reset},
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
  @spec limits_upsert(body :: Gleanex.Platform.UsageLimit.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.UpsertUsageLimitResponse.t()} | {:error, Gleanex.Error.t()}
  def limits_upsert(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.AdminUsage, :limits_upsert},
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

  Requires usage.limit_increase_requests:write, the same scope as personal creation, and current edit permission on the agent, not billing permissions. The caller supplies the agent, client, and optional business justification. Requester identity comes from authentication; the server assigns the request identifier and current UTC month. Requires shared Platform authentication with the required scope, experimental opt-in, and the existing request-more enablement flag. Missing opt-in or a disabled flag returns 404.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec requests_create(body :: Gleanex.Platform.AgentRequestCreate.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.RequestResponse.t()} | {:error, Gleanex.Error.t()}
  def requests_create(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.AdminUsage, :requests_create},
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

  Requires admin.usage.limit_increase_requests:read and current workspace billing read permission. Authorization precedes resource disclosure. Owner-only agent reads are not supported. Supported token issuance, experimental opt-in, and request-more enablement are required. Missing opt-in or a disabled flag returns 404.

  """
  @spec requests_get(request_id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.RequestResponse.t()} | {:error, Gleanex.Error.t()}
  def requests_get(request_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [request_id: request_id],
      call: {Gleanex.Platform.AdminUsage, :requests_get},
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

  Requires admin.usage.limit_increase_requests:read and current workspace billing read permission. Agent ownership is not queue access. Cursors bind filters and current authorization context. Supported token issuance, experimental opt-in, and request-more enablement are required. Missing opt-in or a disabled flag returns 404, not a successful empty page.

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
      call: {Gleanex.Platform.AdminUsage, :requests_list},
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

  Update a pending request with an approval decision or denial. Requires admin.usage.limit_increase_requests:write and current billing edit permission. A pending request can record an approved positive increase amount or be denied with an optional resolution note. PERIOD approval retains the request's stored month and requires the current UTC month; expired approvals return 409 before mutation or approval writes. A successful approval write triggers spend-limit cache refresh before reload; refresh failure logs a warning without failing the decision. The existing backend consumes eligible USER current-period grants to raise enforcement headroom without changing standing rules. This does not add capacity for agents or other unsupported targets, integrate usage settings, or promise new delivery or atomicity guarantees. Supported token issuance, experimental opt-in, and request-more enablement are required. Missing opt-in or a disabled flag returns 404. Once enabled and opted in, ONGOING returns typed 503 without reading or modifying the request; its private policy preparation is not shared with this adapter. Use the existing app operation for ongoing user approvals.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec requests_update(
          request_id :: String.t(),
          body :: Gleanex.Platform.AdministrativeRequestUpdate.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Platform.RequestResponse.t()} | {:error, Gleanex.Error.t()}
  def requests_update(request_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [request_id: request_id, body: body],
      call: {Gleanex.Platform.AdminUsage, :requests_update},
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

  Retrieve workspace-wide policy from the same configuration used by Billing. Group resolution uses the configured policy and its backend defaults; business justification is currently optional. No per-user settings are read, and updated_at is omitted because no policy-update timestamp is available. Requires admin.usage.settings:read and permission to read workspace billing; a global administrator role is not required.

  """
  @spec settings_get(opts :: keyword) ::
          {:ok, Gleanex.Platform.UsageSettingsResponse.t()} | {:error, Gleanex.Error.t()}
  def settings_get(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Gleanex.Platform.AdminUsage, :settings_get},
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

  Assign workspace-wide usage policy. Assignment is currently unavailable until a writer to authoritative Billing configuration is integrated. The backend config platform.usageSettingsWritesEnabled is disabled by default; enabling it alone does not implement assignment, and an authorized request still returns 503 without changing configuration or persisting a second copy of policy. Requires admin.usage.settings:write and permission to edit workspace billing; a global administrator role is not required.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec settings_update(body :: map, opts :: keyword) ::
          {:ok, Gleanex.Platform.UsageSettingsResponse.t()} | {:error, Gleanex.Error.t()}
  def settings_update(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.AdminUsage, :settings_update},
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
end
