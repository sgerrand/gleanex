defmodule Gleanex.Indexing.Troubleshooting do
  @moduledoc """
  Provides API endpoints related to troubleshooting
  """

  @default_client Gleanex.HTTP

  @doc """
  Check document access

  Check if a given user has access to access a document in a custom datasource

  Tip: Refer to the [Troubleshooting tutorial](https://developers.glean.com/indexing/debugging/datasource-config) for more information.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec checkdocumentaccess(
          body :: Gleanex.Indexing.CheckDocumentAccessRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Indexing.CheckDocumentAccessResponse.t()} | {:error, Gleanex.Error.t()}
  def checkdocumentaccess(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Troubleshooting, :checkdocumentaccess},
      url: "/checkdocumentaccess",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.CheckDocumentAccessRequest, :t}}],
      response: [
        {200, {Gleanex.Indexing.CheckDocumentAccessResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Beta: Get document information

  Gives various information that would help in debugging related to a particular document. Currently in beta, might undergo breaking changes without prior notice.

  Tip: Refer to the [Troubleshooting tutorial](https://developers.glean.com/indexing/debugging/datasource-config) for more information.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec debug_datasource_document(
          datasource :: String.t(),
          body :: Gleanex.Indexing.DebugDocumentRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Indexing.DebugDocumentResponse.t()} | {:error, Gleanex.Error.t()}
  def debug_datasource_document(datasource, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [datasource: datasource, body: body],
      call: {Gleanex.Indexing.Troubleshooting, :debug_datasource_document},
      url: "/debug/#{datasource}/document",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.DebugDocumentRequest, :t}}],
      response: [{200, {Gleanex.Indexing.DebugDocumentResponse, :t}}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Beta: Get document lifecycle events

  Retrieves lifecycle events for a specific document including upload time, index times and deletions. Rate limited to 1 request per minute per datasource. Currently in beta, might undergo breaking changes without prior notice.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec debug_datasource_document_events(
          datasource :: String.t(),
          body :: Gleanex.Indexing.DebugDocumentLifecycleRequest.t(),
          opts :: keyword
        ) ::
          {:ok, Gleanex.Indexing.DebugDocumentLifecycleResponse.t()} | {:error, Gleanex.Error.t()}
  def debug_datasource_document_events(datasource, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [datasource: datasource, body: body],
      call: {Gleanex.Indexing.Troubleshooting, :debug_datasource_document_events},
      url: "/debug/#{datasource}/document/events",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.DebugDocumentLifecycleRequest, :t}}],
      response: [
        {200, {Gleanex.Indexing.DebugDocumentLifecycleResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Beta: Get information of a batch of documents

  Gives various information that would help in debugging related to a batch of documents. Currently in beta, might undergo breaking changes without prior notice.

  Tip: Refer to the [Troubleshooting tutorial](https://developers.glean.com/indexing/debugging/datasource-config) for more information.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec debug_datasource_documents(
          datasource :: String.t(),
          body :: Gleanex.Indexing.DebugDocumentsRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Indexing.DebugDocumentsResponse.t()} | {:error, Gleanex.Error.t()}
  def debug_datasource_documents(datasource, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [datasource: datasource, body: body],
      call: {Gleanex.Indexing.Troubleshooting, :debug_datasource_documents},
      url: "/debug/#{datasource}/documents",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.DebugDocumentsRequest, :t}}],
      response: [{200, {Gleanex.Indexing.DebugDocumentsResponse, :t}}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Beta: Get datasource status

  Gather information about the datasource's overall status. Currently in beta, might undergo breaking changes without prior notice.

  Tip: Refer to the [Troubleshooting tutorial](https://developers.glean.com/indexing/debugging/datasource-config) for more information.

  """
  @spec debug_datasource_status(datasource :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Indexing.DebugDatasourceStatusResponse.t()} | {:error, Gleanex.Error.t()}
  def debug_datasource_status(datasource, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [datasource: datasource],
      call: {Gleanex.Indexing.Troubleshooting, :debug_datasource_status},
      url: "/debug/#{datasource}/status",
      method: :post,
      response: [
        {200, {Gleanex.Indexing.DebugDatasourceStatusResponse, :t}},
        {400, :null},
        {401, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Beta: Get user information

  Gives various information that would help in debugging related to a particular user. Currently in beta, might undergo breaking changes without prior notice.

  Tip: Refer to the [Troubleshooting tutorial](https://developers.glean.com/indexing/debugging/datasource-config) for more information.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec debug_datasource_user(
          datasource :: String.t(),
          body :: Gleanex.Indexing.DebugUserRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Indexing.DebugUserResponse.t()} | {:error, Gleanex.Error.t()}
  def debug_datasource_user(datasource, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [datasource: datasource, body: body],
      call: {Gleanex.Indexing.Troubleshooting, :debug_datasource_user},
      url: "/debug/#{datasource}/user",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.DebugUserRequest, :t}}],
      response: [{200, {Gleanex.Indexing.DebugUserResponse, :t}}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get document count

  Fetches document count for the specified custom datasource.

  Tip: Use [/debug/{datasource}/status](https://developers.glean.com/indexing/debugging/datasource-status) for richer information.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec getdocumentcount(body :: Gleanex.Indexing.GetDocumentCountRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Indexing.GetDocumentCountResponse.t()} | {:error, Gleanex.Error.t()}
  def getdocumentcount(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Troubleshooting, :getdocumentcount},
      url: "/getdocumentcount",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.GetDocumentCountRequest, :t}}],
      response: [
        {200, {Gleanex.Indexing.GetDocumentCountResponse, :t}},
        {400, :null},
        {401, :null},
        {409, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get document upload and indexing status

  Intended for debugging/validation. Fetches the current upload and indexing status of documents.

  Tip: Use [/debug/{datasource}/document](https://developers.glean.com/indexing/debugging/datasource-document) for richer information.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec getdocumentstatus(body :: Gleanex.Indexing.GetDocumentStatusRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Indexing.GetDocumentStatusResponse.t()} | {:error, Gleanex.Error.t()}
  def getdocumentstatus(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Troubleshooting, :getdocumentstatus},
      url: "/getdocumentstatus",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.GetDocumentStatusRequest, :t}}],
      response: [
        {200, {Gleanex.Indexing.GetDocumentStatusResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get user count

  Fetches user count for the specified custom datasource.

  Tip: Use [/debug/{datasource}/status](https://developers.glean.com/indexing/debugging/datasource-status) for richer information.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec getusercount(body :: Gleanex.Indexing.GetUserCountRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Indexing.GetUserCountResponse.t()} | {:error, Gleanex.Error.t()}
  def getusercount(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Troubleshooting, :getusercount},
      url: "/getusercount",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.GetUserCountRequest, :t}}],
      response: [
        {200, {Gleanex.Indexing.GetUserCountResponse, :t}},
        {400, :null},
        {401, :null},
        {409, :null}
      ],
      opts: opts
    })
  end
end
