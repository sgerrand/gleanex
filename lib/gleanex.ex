defmodule Gleanex do
  @moduledoc """
  Elixir client for Glean.

  Gleanex covers all four of Glean's public APIs, generated from the OpenAPI
  descriptions Glean publishes at
  [gleanwork/open-api](https://github.com/gleanwork/open-api):

    * `Gleanex.Client` - search, chat, agents, documents, collections and the
      rest of the day to day surface
    * `Gleanex.Indexing` - pushing documents, people and permissions into the
      index
    * `Gleanex.Platform` - agents, skills and the newer search endpoints
    * `Gleanex.Admin` - governance and datasource administration

  ## Getting started

      config = Gleanex.new(domain: "mycompany", token: System.fetch_env!("GLEAN_API_TOKEN"))

      {:ok, response} = Gleanex.Client.Search.search(%{query: "company holidays"}, config: config)

  With `GLEAN_INSTANCE` and `GLEAN_API_TOKEN` exported, the config can be left
  out entirely and each call falls back to `Gleanex.Config.default/0`.

  ## Tokens are scoped

  Client and Indexing tokens are not interchangeable. Build one config per
  scope, and Gleanex will refuse a mismatched call before it leaves your
  machine:

      indexing = Gleanex.new(domain: "mycompany", token: indexing_token, scope: :indexing)
      {:ok, _} = Gleanex.Indexing.Documents.index_document(%{document: doc}, config: indexing)

  ## Results

  Every operation returns `{:ok, result}` or `{:error, %Gleanex.Error{}}`, never
  both. See `Gleanex.Error` for the failure reasons.

  ## Retries and timeouts

  Requests retry transient failures by default, honouring `Retry-After` on rate
  limits. See `Gleanex.Retry` to change the policy, globally or per call.
  """

  alias Gleanex.Client.Chat
  alias Gleanex.Client.ChatMessage
  alias Gleanex.Client.ChatMessageFragment
  alias Gleanex.Client.ChatRequest
  alias Gleanex.Client.Search
  alias Gleanex.Client.SearchRequest
  alias Gleanex.Config

  @doc """
  Build a `Gleanex.Config`.

  See `Gleanex.Config.new/1` for the full list of options.

  ## Examples

      Gleanex.new(domain: "mycompany", token: token)
      Gleanex.new(domain: "mycompany", token: indexing_token, scope: :indexing)
      Gleanex.new(base_url: "https://be4f5226-be.glean.com", token: token)

  """
  @spec new(keyword) :: Config.t()
  defdelegate new(opts \\ []), to: Config

  @doc """
  Search, for the common case of a plain query string.

  Shorthand for `Gleanex.Client.Search.search/2` with a body of just `query`.
  Extra `Gleanex.Client.SearchRequest` fields go in `opts` under `:body`, and an
  unknown field raises rather than being dropped. Everything else in `opts` is
  passed to the operation.

  ## Examples

      {:ok, response} = Gleanex.search(config, "company holidays")

      {:ok, response} = Gleanex.search(config, "company holidays", body: %{pageSize: 50})

  For anything more involved, call the operation directly:

      Gleanex.Client.Search.search(%{query: "holidays", requestOptions: options}, config: config)

  """
  @spec search(Config.t(), String.t(), keyword) ::
          {:ok, Gleanex.Client.SearchResponse.t()} | {:error, Gleanex.Error.t()}
  def search(%Config{} = config, query, opts \\ []) when is_binary(query) do
    {body, opts} = Keyword.pop(opts, :body, %{})
    request = struct!(SearchRequest, Map.put(body, :query, query))

    Search.search(request, Keyword.put(opts, :config, config))
  end

  @doc """
  Ask Glean a single question.

  Shorthand for `Gleanex.Client.Chat.chat/2` with one user message. Use the
  operation directly to continue a conversation, and `Gleanex.Streaming.chat/3`
  to receive the answer as it is written.

  ## Examples

      {:ok, response} = Gleanex.chat(config, "What are the company holidays this year?")

  """
  @spec chat(Config.t(), String.t(), keyword) ::
          {:ok, Gleanex.Client.ChatResponse.t()} | {:error, Gleanex.Error.t()}
  def chat(%Config{} = config, message, opts \\ []) when is_binary(message) do
    {body, opts} = Keyword.pop(opts, :body, %{})

    messages = [
      %ChatMessage{author: "USER", fragments: [%ChatMessageFragment{text: message}]}
    ]

    request = struct!(ChatRequest, Map.put(body, :messages, messages))

    Chat.chat(request, Keyword.put(opts, :config, config))
  end
end
