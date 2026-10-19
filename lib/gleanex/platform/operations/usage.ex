defmodule Gleanex.Platform.Usage do
  @moduledoc """
  Provides API endpoints related to usage
  """

  @default_client Gleanex.HTTP

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

  Requires usage.limit_increase_requests:write. The target is the authenticated canonical user, and requester identity comes from authentication. The caller supplies the client and optional business justification. The server assigns the request identifier and current UTC month. Billing grants do not widen this route. Requires shared Platform authentication with the required scope, experimental opt-in, and the existing request-more enablement flag. Missing opt-in or a disabled flag returns 404.

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

  Requires usage.limit_increase_requests:read and the current user's request. Authorization precedes resource disclosure. Missing and inaccessible records return the same 404. Supported token issuance, experimental opt-in, and request-more enablement are required. Missing opt-in or a disabled flag also returns 404.

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

  Requires usage.limit_increase_requests:read. The collection is limited to the authenticated canonical user's requests, including resolved requests. Cursors bind the filters and current authorization context; a billing grant cannot widen results. Supported token issuance, experimental opt-in, and request-more enablement are required. Missing opt-in or a disabled flag returns 404.

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
