defmodule Gleanex.Platform.Chat do
  @moduledoc """
  Provides API endpoints related to chat
  """

  @default_client Gleanex.HTTP

  @doc """
  Create a chat response

  Run an assistant turn. The default response is JSON. HTTP clients request server-sent events by setting `stream` to true in the JSON body. An `Accept: text/event-stream` header does not replace `stream`.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec create(body :: Gleanex.Platform.ChatCreateRequest.t(), opts :: keyword) ::
          {:ok,
           Gleanex.Platform.ChatCompletedResponse.t()
           | Gleanex.Platform.ChatStreamOutputTextDelta.t()
           | Gleanex.Platform.ChatStreamOutputTextDone.t()
           | Gleanex.Platform.ChatStreamProgress.t()
           | Gleanex.Platform.ChatStreamResponseCompleted.t()
           | Gleanex.Platform.ChatStreamResponseCreated.t()
           | Gleanex.Platform.ChatStreamResponseFailed.t()}
          | {:error, Gleanex.Error.t()}
  def create(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.Chat, :create},
      url: "/chat",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Platform.ChatCreateRequest, :t}}],
      response: [
        {200,
         {:union,
          [
            {Gleanex.Platform.ChatCompletedResponse, :t},
            {Gleanex.Platform.ChatStreamOutputTextDelta, :t},
            {Gleanex.Platform.ChatStreamOutputTextDone, :t},
            {Gleanex.Platform.ChatStreamProgress, :t},
            {Gleanex.Platform.ChatStreamResponseCompleted, :t},
            {Gleanex.Platform.ChatStreamResponseCreated, :t},
            {Gleanex.Platform.ChatStreamResponseFailed, :t}
          ]}},
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

  @doc """
  Update a chat

  Update the name of a chat. Only the chat owner can update it.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec update(
          chat_id :: String.t(),
          body :: Gleanex.Platform.ChatUpdateRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Platform.ChatUpdateResponse.t()} | {:error, Gleanex.Error.t()}
  def update(chat_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [chat_id: chat_id, body: body],
      call: {Gleanex.Platform.Chat, :update},
      url: "/chats/#{chat_id}",
      body: body,
      method: :patch,
      request: [{"application/json", {Gleanex.Platform.ChatUpdateRequest, :t}}],
      response: [
        {200, {Gleanex.Platform.ChatUpdateResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {405, {Gleanex.Platform.ProblemDetail, :t}},
        {413, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @type t :: %__MODULE__{chat_id: String.t(), name: String.t()}

  defstruct [:chat_id, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [chat_id: :string, name: :string]
  end
end
