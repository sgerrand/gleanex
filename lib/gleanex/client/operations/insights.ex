defmodule Gleanex.Client.Insights do
  @moduledoc """
  Provides API endpoint related to insights
  """

  @default_client Gleanex.HTTP

  @doc """
  Get insights

  Gets the aggregate usage insights data displayed in the Insights Dashboards.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Includes request parameters for insights requests.
  """
  @spec insights(body :: Gleanex.Client.InsightsRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.InsightsResponse.t()} | {:error, Gleanex.Error.t()}
  def insights(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Insights, :insights},
      url: "/insights",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.InsightsRequest, :t}}],
      response: [
        {200, {Gleanex.Client.InsightsResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end
end
