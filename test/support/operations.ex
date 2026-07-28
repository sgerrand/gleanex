defmodule Gleanex.Client.SupportSearch do
  @moduledoc """
  A hand-written copy of what `oapi_generator` emits for `POST /search`.

  This exists to exercise `Gleanex.HTTP` against the exact operation map the
  generator produces, without depending on generated code. The `Gleanex.Client.`
  prefix is deliberate: it is what makes `Gleanex.HTTP.api_for/1` resolve the
  `/rest/api/v1` prefix.
  """

  alias Gleanex.Support.Schemas.SearchResponse

  @default_client Gleanex.HTTP

  @doc false
  @spec search(map, keyword) :: {:ok, SearchResponse.t()} | {:error, Gleanex.Error.t()}
  def search(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {__MODULE__, :search},
      url: "/search",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, {SearchResponse, :t}}],
      opts: opts
    })
  end
end

defmodule Gleanex.Indexing.SupportDocuments do
  @moduledoc """
  A hand-written copy of a generated Indexing operation, used to prove scope
  enforcement and the `/api/index/v1` prefix.
  """

  @default_client Gleanex.HTTP

  @doc false
  @spec index_document(map, keyword) :: {:ok, term} | {:error, Gleanex.Error.t()}
  def index_document(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {__MODULE__, :index_document},
      url: "/indexdocument",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :null}],
      opts: opts
    })
  end
end

defmodule Gleanex.Admin.SupportDatasources do
  @moduledoc """
  A hand-written copy of a generated operation that takes path and query
  parameters, used to prove URL interpolation and query encoding.
  """

  @default_client Gleanex.HTTP

  @doc false
  @spec credential_status(String.t(), keyword) :: {:ok, term} | {:error, Gleanex.Error.t()}
  def credential_status(datasource_instance_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:verbose])

    client.request(%{
      args: [datasourceInstanceId: datasource_instance_id],
      call: {__MODULE__, :credential_status},
      url: "/datasource/#{datasource_instance_id}/credentialstatus",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end
end
