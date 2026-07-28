defmodule Gleanex.Client.Documents do
  @moduledoc """
  Provides API endpoints related to documents
  """

  @default_client Gleanex.HTTP

  @doc """
  Read document permissions

  Read the emails of all users who have access to the given document.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Document permissions request
  """
  @spec getdocpermissions(body :: Gleanex.Client.GetDocPermissionsRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.GetDocPermissionsResponse.t()} | {:error, Gleanex.Error.t()}
  def getdocpermissions(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Documents, :getdocpermissions},
      url: "/getdocpermissions",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.GetDocPermissionsRequest, :t}}],
      response: [
        {200, {Gleanex.Client.GetDocPermissionsResponse, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Read documents

  Read the documents including metadata (does not include enhanced metadata via `/documentmetadata`) for the given list of Glean Document IDs or URLs specified in the request.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Information about documents requested.
  """
  @spec getdocuments(body :: Gleanex.Client.GetDocumentsRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.GetDocumentsResponse.t()} | {:error, Gleanex.Error.t()}
  def getdocuments(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Documents, :getdocuments},
      url: "/getdocuments",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.GetDocumentsRequest, :t}}],
      response: [
        {200, {Gleanex.Client.GetDocumentsResponse, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Read documents by facets

  Read the documents including metadata (does not include enhanced metadata via `/documentmetadata`) macthing the given facet conditions.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Information about facet conditions for documents to be retrieved.
  """
  @spec getdocumentsbyfacets(
          body :: Gleanex.Client.GetDocumentsByFacetsRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Client.GetDocumentsByFacetsResponse.t()} | {:error, Gleanex.Error.t()}
  def getdocumentsbyfacets(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Documents, :getdocumentsbyfacets},
      url: "/getdocumentsbyfacets",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.GetDocumentsByFacetsRequest, :t}}],
      response: [
        {200, {Gleanex.Client.GetDocumentsByFacetsResponse, :t}},
        {400, :null},
        {401, :null},
        {404, :null},
        {429, :null}
      ],
      opts: opts
    })
  end
end
