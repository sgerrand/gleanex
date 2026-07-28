defmodule Gleanex.Indexing.Documents do
  @moduledoc """
  Provides API endpoints related to documents
  """

  @default_client Gleanex.HTTP

  @doc """
  Bulk index documents

  Replaces the documents in a datasource using paginated batch API calls. Please refer to the [bulk indexing](https://developers.glean.com/indexing/documents/bulk-upload-model) documentation for an explanation of how to use bulk endpoints.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec bulkindexdocuments(
          body :: Gleanex.Indexing.BulkIndexDocumentsRequest.t(),
          opts :: keyword
        ) :: :ok | {:error, Gleanex.Error.t()}
  def bulkindexdocuments(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Documents, :bulkindexdocuments},
      url: "/bulkindexdocuments",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.BulkIndexDocumentsRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Delete document

  Deletes the specified document from the index. Succeeds if document is not present.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec deletedocument(body :: Gleanex.Indexing.DeleteDocumentRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def deletedocument(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Documents, :deletedocument},
      url: "/deletedocument",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.DeleteDocumentRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Index document

  Adds a document to the index or updates an existing document.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec indexdocument(body :: Gleanex.Indexing.IndexDocumentRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def indexdocument(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Documents, :indexdocument},
      url: "/indexdocument",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.IndexDocumentRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Index documents

  Adds or updates multiple documents in the index. Please refer to the [bulk indexing](https://developers.glean.com/indexing/documents/bulk-indexing/choosing-indexdocuments-vs-bulkindexdocuments) documentation for an explanation of when to use this endpoint.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec indexdocuments(body :: Gleanex.Indexing.IndexDocumentsRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def indexdocuments(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Documents, :indexdocuments},
      url: "/indexdocuments",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.IndexDocumentsRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Schedules the processing of uploaded documents

  Schedules the immediate processing of documents uploaded through the indexing API. By default the uploaded documents will be processed asynchronously but this API can be used to schedule processing of all documents on demand.

  If a `datasource` parameter is specified, processing is limited to that custom datasource. Without it, processing applies to all documents across all custom datasources.
  #### Rate Limits
  This endpoint is rate-limited to one usage every 3 hours. Exceeding this limit results in a 429 response code. Here's how the rate limit works:
  1. Calling `/processalldocuments` for datasource `foo` prevents another call for `foo` for 3 hours.
  2. Calling `/processalldocuments` for datasource `foo` doesn't affect immediate calls for `bar`.
  3. Calling `/processalldocuments` for all datasources prevents any datasource calls for 3 hours.
  4. Calling `/processalldocuments` for datasource `foo` doesn't affect immediate calls for all datasources.

  For more frequent document processing, contact Glean support.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec processalldocuments(
          body :: Gleanex.Indexing.ProcessAllDocumentsRequest.t(),
          opts :: keyword
        ) :: :ok | {:error, Gleanex.Error.t()}
  def processalldocuments(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Documents, :processalldocuments},
      url: "/processalldocuments",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.ProcessAllDocumentsRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Update document permissions

  Updates the permissions for a given document without modifying document content.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec updatepermissions(body :: Gleanex.Indexing.UpdatePermissionsRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def updatepermissions(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Documents, :updatepermissions},
      url: "/updatepermissions",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.UpdatePermissionsRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}, {429, :null}],
      opts: opts
    })
  end
end
