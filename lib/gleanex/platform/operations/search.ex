defmodule Gleanex.Platform.Search do
  @moduledoc """
  Provides API endpoints related to search
  """

  @default_client Gleanex.HTTP

  @doc """
  List search filters

  List datasources and common built-in filter fields visible to the authenticated user. This is a best-effort catalog, not an exhaustive list of every filter search accepts.
  Without `query`, returns field metadata only and does not run a search. With a nonblank `query`, provide exactly one `datasources` value to request suggested filter values for that query; no documents are returned and this endpoint does not include warning objects. See `FilterFieldInfo.values` for limitations on suggested values. Rate-limited requests return HTTP 429 with `Retry-After`; temporary backend unavailability returns HTTP 503.

  ## Options

    * `datasources`: Restrict metadata to one or more datasource identifiers as returned by this endpoint (for example, `jira`). With a nonblank `query`, exactly one datasource is required. Unknown or inaccessible identifiers return `invalid_datasource`.
      
    * `query`: Optional search query that requests suggested filter values for the selected datasource. Must be nonblank when present. Triggers a search for facet values only; does not return documents.
      

  """
  @spec filters(opts :: keyword) ::
          {:ok, Gleanex.Platform.SearchFiltersResponse.t()} | {:error, Gleanex.Error.t()}
  def filters(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:datasources, :query])

    client.request(%{
      args: [],
      call: {Gleanex.Platform.Search, :filters},
      url: "/search/filters",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Platform.SearchFiltersResponse, :t}},
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
  Search

  Search your organization's connected content and return ranked document results with cursor pagination. Use `GET /api/search/filters` to discover datasource identifiers and common filter fields. Built-in filter names are validated; other field names are accepted as custom filters and behavior depends on your Glean configuration and connected sources.
  Errors: HTTP 422 `unprocessable_query` returns no `results` or `next_cursor`. See `warnings` on the response for non-blocking issues such as partially available results. Not every query issue produces a warning or error.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec search(body :: Gleanex.Platform.SearchRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.SearchResponse.t()} | {:error, Gleanex.Error.t()}
  def search(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.Search, :search},
      url: "/search",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Platform.SearchRequest, :t}}],
      response: [
        {200, {Gleanex.Platform.SearchResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {413, {Gleanex.Platform.ProblemDetail, :t}},
        {422, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end
end
