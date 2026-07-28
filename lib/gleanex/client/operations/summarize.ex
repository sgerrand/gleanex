defmodule Gleanex.Client.Summarize do
  @moduledoc """
  Provides API endpoint related to summarize
  """

  @default_client Gleanex.HTTP

  @doc """
  Summarize documents

  Generate an AI summary of the requested documents.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Includes request params such as the query and specs of the documents to summarize.
  """
  @spec summarize(body :: Gleanex.Client.SummarizeRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.SummarizeResponse.t()} | {:error, Gleanex.Error.t()}
  def summarize(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Summarize, :summarize},
      url: "/summarize",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.SummarizeRequest, :t}}],
      response: [
        {200, {Gleanex.Client.SummarizeResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end
end
