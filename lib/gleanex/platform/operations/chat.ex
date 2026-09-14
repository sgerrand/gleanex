defmodule Gleanex.Platform.Chat do
  @moduledoc """
  Provides API endpoint related to chat
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
end
