defmodule Gleanex.Indexing.Datasources do
  @moduledoc """
  Provides API endpoints related to datasources
  """

  @default_client Gleanex.HTTP

  @doc """
  Add or update datasource

  Add or update a custom datasource and its schema.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec adddatasource(body :: Gleanex.Indexing.CustomDatasourceConfig.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def adddatasource(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Datasources, :adddatasource},
      url: "/adddatasource",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.CustomDatasourceConfig, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get datasource config

  Fetches the datasource config for the specified custom datasource.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec getdatasourceconfig(
          body :: Gleanex.Indexing.GetDatasourceConfigRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Indexing.CustomDatasourceConfig.t()} | {:error, Gleanex.Error.t()}
  def getdatasourceconfig(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Datasources, :getdatasourceconfig},
      url: "/getdatasourceconfig",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Indexing.GetDatasourceConfigRequest, :t}}],
      response: [
        {200, {Gleanex.Indexing.CustomDatasourceConfig, :t}},
        {400, :null},
        {401, :null},
        {409, :null}
      ],
      opts: opts
    })
  end

  @type submissions_datasource_instance_type_202_json_resp :: %{requestId: String.t()}

  @doc """
  Submit datasource data

  Validates and asynchronously processes a datasource-specific submission.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec submissions_datasource_instance_type(
          datasourceInstance :: String.t(),
          type :: String.t(),
          body :: map,
          opts :: keyword
        ) ::
          {:ok, Gleanex.Indexing.Datasources.submissions_datasource_instance_type_202_json_resp()}
          | {:error, Gleanex.Error.t()}
  def submissions_datasource_instance_type(datasourceInstance, type, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [datasourceInstance: datasourceInstance, type: type, body: body],
      call: {Gleanex.Indexing.Datasources, :submissions_datasource_instance_type},
      url: "/submissions/#{datasourceInstance}/#{type}",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {202,
         {Gleanex.Indexing.Datasources, :submissions_datasource_instance_type_202_json_resp}},
        {400, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {401, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {404, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {405, :null},
        {413, :null},
        {500, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {503, :null}
      ],
      opts: opts
    })
  end

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:submissions_datasource_instance_type_202_json_resp) do
    [requestId: :string]
  end
end
