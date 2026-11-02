defmodule Gleanex.Platform.Documents do
  @moduledoc """
  Provides API endpoints related to documents
  """

  @default_client Gleanex.HTTP

  @doc """
  Batch get documents

  Retrieve up to 100 permission-visible indexed documents by URL or document_id. Found items are in results. Complete misses are warnings correlated by index. Incomplete store work fails the whole request. Retrieving search results is best-effort parity with legacy getdocuments. Gmail and Outlook caller-specific citation IDs are not accepted as document_id selectors. Use URL selectors for them. A Gmail or Outlook URL can still return a resource_not_found warning. Federated results and go-link shortcut documents are not retrievable in this release.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec batch(body :: Gleanex.Platform.DocumentsBatchRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.DocumentsBatchResponse.t()} | {:error, Gleanex.Error.t()}
  def batch(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.Documents, :batch},
      url: "/documents/batch",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Platform.DocumentsBatchRequest, :t}}],
      response: [
        {200, {Gleanex.Platform.DocumentsBatchResponse, :t}},
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
  Get document by ID

  Retrieve one permission-visible indexed document by its Glean store ID. Gmail and Outlook search results and chat citations can carry caller-specific IDs that this operation cannot resolve. Try get document by URL for those documents. URL lookup does not resolve every Gmail or Outlook result.

  ## Options

    * `include`: Optional field groups to add to each found document. Each value only adds fields; it does not change which documents are returned.
      

  """
  @spec get(document_id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.DocumentGetResponse.t()} | {:error, Gleanex.Error.t()}
  def get(document_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:include])

    client.request(%{
      args: [document_id: document_id],
      call: {Gleanex.Platform.Documents, :get},
      url: "/documents/#{document_id}",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Platform.DocumentGetResponse, :t}},
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
  Get document by URL

  Retrieve one permission-visible indexed document by URL. The url is the lookup key that Platform search returns. Many URLs can resolve to one document. The response is a single document, not a list. The returned url is the permalink and may differ from the submitted URL. Gmail and Outlook search results and chat citations carry caller-specific IDs that get document by ID cannot resolve, so retrieve them by URL here. A Gmail or Outlook URL that Platform search returned can still return 404, as it can with legacy getdocuments. Retrieving search results is best-effort parity with legacy getdocuments. Federated results and go-link shortcut documents are not retrievable in this release.

  ## Options

    * `url`: URL of the document to retrieve.
    * `include`: Optional field groups to add to each found document. Each value only adds fields; it does not change which documents are returned.
      

  """
  @spec get_by_url(opts :: keyword) ::
          {:ok, Gleanex.Platform.DocumentGetResponse.t()} | {:error, Gleanex.Error.t()}
  def get_by_url(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:include, :url])

    client.request(%{
      args: [],
      call: {Gleanex.Platform.Documents, :get_by_url},
      url: "/documents",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Platform.DocumentGetResponse, :t}},
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
