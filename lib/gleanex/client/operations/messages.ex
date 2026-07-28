defmodule Gleanex.Client.Messages do
  @moduledoc """
  Provides API endpoint related to messages
  """

  @default_client Gleanex.HTTP

  @doc """
  Read messages

  Retrieves list of messages from messaging/chat datasources (e.g. Slack, Teams).

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Includes request params such as the id for channel/message and direction.
  """
  @spec messages(body :: Gleanex.Client.MessagesRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.MessagesResponse.t()} | {:error, Gleanex.Error.t()}
  def messages(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Messages, :messages},
      url: "/messages",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.MessagesRequest, :t}}],
      response: [
        {200, {Gleanex.Client.MessagesResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end
end
