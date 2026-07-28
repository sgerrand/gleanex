defmodule Gleanex.Client.Search do
  @moduledoc """
  Provides API endpoints related to search
  """

  @default_client Gleanex.HTTP

  @doc """
  Search the index (admin)

  Retrieves results for search query without respect for permissions. This is available only to privileged users.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Admin search request
  """
  @spec adminsearch(body :: Gleanex.Client.SearchRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.SearchResponse.t()} | {:error, Gleanex.Error.t()}
  def adminsearch(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Search, :adminsearch},
      url: "/adminsearch",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.SearchRequest, :t}}],
      response: [
        {200, {Gleanex.Client.SearchResponse, :t}},
        {400, :null},
        {401, :null},
        {403, {Gleanex.Client.ErrorInfo, :t}},
        {422, {Gleanex.Client.ErrorInfo, :t}},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Autocomplete

  Retrieve query suggestions, operators and documents for the given partially typed query.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Autocomplete request
  """
  @spec autocomplete(body :: Gleanex.Client.AutocompleteRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.AutocompleteResponse.t()} | {:error, Gleanex.Error.t()}
  def autocomplete(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Search, :autocomplete},
      url: "/autocomplete",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.AutocompleteRequest, :t}}],
      response: [
        {200, {Gleanex.Client.AutocompleteResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Feed of documents and events

  The personalized feed/home includes different types of contents including suggestions, recents, calendar events and many more.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Includes request params, client data and more for making user's feed.
  """
  @spec feed(body :: Gleanex.Client.FeedRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.FeedResponse.t()} | {:error, Gleanex.Error.t()}
  def feed(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Search, :feed},
      url: "/feed",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.FeedRequest, :t}}],
      response: [
        {200, {Gleanex.Client.FeedResponse, :t}},
        {400, :null},
        {401, :null},
        {408, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Recommend documents

  Retrieve recommended documents for the given URL or Glean Document ID.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Recommendations request
  """
  @spec recommendations(body :: Gleanex.Client.RecommendationsRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.RecommendationsResponse.t()} | {:error, Gleanex.Error.t()}
  def recommendations(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Search, :recommendations},
      url: "/recommendations",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.RecommendationsRequest, :t}}],
      response: [
        {200, {Gleanex.Client.RecommendationsResponse, :t}},
        {202, :null},
        {204, :null},
        {400, :null},
        {401, :null},
        {403, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Search

  Retrieve results from the index for the given query and filters.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Search request
  """
  @spec search(body :: Gleanex.Client.SearchRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.SearchResponse.t()} | {:error, Gleanex.Error.t()}
  def search(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Search, :search},
      url: "/search",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.SearchRequest, :t}}],
      response: [
        {200, {Gleanex.Client.SearchResponse, :t}},
        {400, :null},
        {401, :null},
        {403, {Gleanex.Client.ErrorInfo, :t}},
        {408, :null},
        {422, {Gleanex.Client.ErrorInfo, :t}},
        {429, :null}
      ],
      opts: opts
    })
  end
end
