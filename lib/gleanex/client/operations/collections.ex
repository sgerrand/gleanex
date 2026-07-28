defmodule Gleanex.Client.Collections do
  @moduledoc """
  Provides API endpoints related to collections
  """

  @default_client Gleanex.HTTP

  @doc """
  Add Collection item

  Add items to a Collection.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Data describing the add operation.
  """
  @spec addcollectionitems(body :: Gleanex.Client.AddCollectionItemsRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.AddCollectionItemsResponse.t()} | {:error, Gleanex.Error.t()}
  def addcollectionitems(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Collections, :addcollectionitems},
      url: "/addcollectionitems",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.AddCollectionItemsRequest, :t}}],
      response: [
        {200, {Gleanex.Client.AddCollectionItemsResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Create Collection

  Create a publicly visible (empty) Collection of documents.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Collection content plus any additional metadata for the request.
  """
  @spec createcollection(body :: Gleanex.Client.CreateCollectionRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.CreateCollectionResponse.t()} | {:error, Gleanex.Error.t()}
  def createcollection(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Collections, :createcollection},
      url: "/createcollection",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.CreateCollectionRequest, :t}}],
      response: [
        {200, {Gleanex.Client.CreateCollectionResponse, :t}},
        {400, :null},
        {401, :null},
        {422, {Gleanex.Client.CollectionError, :t}},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Delete Collection

  Delete a Collection given the Collection's ID.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  DeleteCollection request
  """
  @spec deletecollection(body :: Gleanex.Client.DeleteCollectionRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def deletecollection(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Collections, :deletecollection},
      url: "/deletecollection",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.DeleteCollectionRequest, :t}}],
      response: [
        {200, :null},
        {400, :null},
        {401, :null},
        {422, {Gleanex.Client.CollectionError, :t}},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Delete Collection item

  Delete a single item from a Collection.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Data describing the delete operation.
  """
  @spec deletecollectionitem(
          body :: Gleanex.Client.DeleteCollectionItemRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Client.DeleteCollectionItemResponse.t()} | {:error, Gleanex.Error.t()}
  def deletecollectionitem(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Collections, :deletecollectionitem},
      url: "/deletecollectionitem",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.DeleteCollectionItemRequest, :t}}],
      response: [
        {200, {Gleanex.Client.DeleteCollectionItemResponse, :t}},
        {400, :null},
        {401, :null},
        {422, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Update Collection

  Update the properties of an existing Collection.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Collection content plus any additional metadata for the request.
  """
  @spec editcollection(body :: Gleanex.Client.EditCollectionRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.EditCollectionResponse.t()} | {:error, Gleanex.Error.t()}
  def editcollection(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Collections, :editcollection},
      url: "/editcollection",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.EditCollectionRequest, :t}}],
      response: [
        {200, {Gleanex.Client.EditCollectionResponse, :t}},
        {400, :null},
        {401, :null},
        {422, {Gleanex.Client.CollectionError, :t}},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Update Collection item

  Update the URL, Glean Document ID, description of an item within a Collection given its ID.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Edit Collection Items request
  """
  @spec editcollectionitem(body :: Gleanex.Client.EditCollectionItemRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.EditCollectionItemResponse.t()} | {:error, Gleanex.Error.t()}
  def editcollectionitem(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Collections, :editcollectionitem},
      url: "/editcollectionitem",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.EditCollectionItemRequest, :t}}],
      response: [
        {200, {Gleanex.Client.EditCollectionItemResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Read Collection

  Read the details of a Collection given its ID. Does not fetch items in this Collection.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  GetCollection request
  """
  @spec getcollection(body :: Gleanex.Client.GetCollectionRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.GetCollectionResponse.t()} | {:error, Gleanex.Error.t()}
  def getcollection(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Collections, :getcollection},
      url: "/getcollection",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.GetCollectionRequest, :t}}],
      response: [
        {200, {Gleanex.Client.GetCollectionResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  List Collections

  List all existing Collections.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  ListCollections request
  """
  @spec listcollections(body :: Gleanex.Client.ListCollectionsRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.ListCollectionsResponse.t()} | {:error, Gleanex.Error.t()}
  def listcollections(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Collections, :listcollections},
      url: "/listcollections",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.ListCollectionsRequest, :t}}],
      response: [
        {200, {Gleanex.Client.ListCollectionsResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end
end
