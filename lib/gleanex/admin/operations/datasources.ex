defmodule Gleanex.Admin.Datasources do
  @moduledoc """
  Provides API endpoints related to datasources
  """

  @default_client Gleanex.HTTP

  @doc """
  Get datasource instance credential status

  Returns the current credential status for a datasource instance. Access is limited to callers with the ADMIN scope; the handler enforces this check.

  """
  @spec get_datasource_credential_status(datasourceInstanceId :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Admin.DatasourceCredentialStatusResponse.t()}
          | {:error, Gleanex.Error.t()}
  def get_datasource_credential_status(datasourceInstanceId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [datasourceInstanceId: datasourceInstanceId],
      call: {Gleanex.Admin.Datasources, :get_datasource_credential_status},
      url: "/datasource/#{datasourceInstanceId}/credentialstatus",
      method: :get,
      response: [
        {200, {Gleanex.Admin.DatasourceCredentialStatusResponse, :t}},
        {400, {Gleanex.Admin.ErrorResponse, :t}},
        {401, :null},
        {403, {Gleanex.Admin.ErrorResponse, :t}},
        {404, {Gleanex.Admin.ErrorResponse, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get datasource instance configuration

  Gets the greenlisted configuration values for a datasource instance. Returns only configuration keys that are exposed via the public API greenlist.

  """
  @spec get_datasource_instance_configuration(
          datasourceId :: String.t(),
          instanceId :: String.t(),
          opts :: keyword
        ) ::
          {:ok, Gleanex.Admin.DatasourceConfigurationResponse.t()} | {:error, Gleanex.Error.t()}
  def get_datasource_instance_configuration(datasourceId, instanceId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [datasourceId: datasourceId, instanceId: instanceId],
      call: {Gleanex.Admin.Datasources, :get_datasource_instance_configuration},
      url: "/configure/datasources/#{datasourceId}/instances/#{instanceId}",
      method: :get,
      response: [
        {200, {Gleanex.Admin.DatasourceConfigurationResponse, :t}},
        {400, {Gleanex.Admin.ErrorResponse, :t}},
        {401, :null},
        {403, {Gleanex.Admin.ErrorResponse, :t}},
        {404, {Gleanex.Admin.ErrorResponse, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Rotate datasource instance credentials

  Rotates the credentials that a datasource instance uses to connect to its upstream system. Replaces the active credential material with the supplied values and returns the credential status after rotation. Access is limited to callers with the ADMIN scope; the handler enforces this check.
  Only keys recognized as credential material for the datasource type may be set in `credentials.values` (e.g. `clientSecret`, `apiToken`, `privateKey`, depending on the configured auth method). Unrecognized keys, or keys that correspond to non-credential configuration, cause a 400; other instance configuration must be updated via PATCH /configure/datasources/{datasourceId}/instances/{instanceId}.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec rotate_datasource_credentials(
          datasourceInstanceId :: String.t(),
          body :: Gleanex.Admin.RotateDatasourceCredentialsRequest.t(),
          opts :: keyword
        ) ::
          {:ok, Gleanex.Admin.DatasourceCredentialStatusResponse.t()}
          | {:error, Gleanex.Error.t()}
  def rotate_datasource_credentials(datasourceInstanceId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [datasourceInstanceId: datasourceInstanceId, body: body],
      call: {Gleanex.Admin.Datasources, :rotate_datasource_credentials},
      url: "/datasource/#{datasourceInstanceId}/credentials",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Admin.RotateDatasourceCredentialsRequest, :t}}],
      response: [
        {200, {Gleanex.Admin.DatasourceCredentialStatusResponse, :t}},
        {400, {Gleanex.Admin.ErrorResponse, :t}},
        {401, :null},
        {403, {Gleanex.Admin.ErrorResponse, :t}},
        {404, {Gleanex.Admin.ErrorResponse, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update datasource instance configuration

  Updates the greenlisted configuration values for a datasource instance. Only configuration keys that are exposed via the public API greenlist may be set. Returns the full greenlisted configuration after the update is applied.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec update_datasource_instance_configuration(
          datasourceId :: String.t(),
          instanceId :: String.t(),
          body :: Gleanex.Admin.UpdateDatasourceConfigurationRequest.t(),
          opts :: keyword
        ) ::
          {:ok, Gleanex.Admin.DatasourceConfigurationResponse.t()} | {:error, Gleanex.Error.t()}
  def update_datasource_instance_configuration(datasourceId, instanceId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [datasourceId: datasourceId, instanceId: instanceId, body: body],
      call: {Gleanex.Admin.Datasources, :update_datasource_instance_configuration},
      url: "/configure/datasources/#{datasourceId}/instances/#{instanceId}",
      body: body,
      method: :patch,
      request: [{"application/json", {Gleanex.Admin.UpdateDatasourceConfigurationRequest, :t}}],
      response: [
        {200, {Gleanex.Admin.DatasourceConfigurationResponse, :t}},
        {400, {Gleanex.Admin.ErrorResponse, :t}},
        {401, :null},
        {403, {Gleanex.Admin.ErrorResponse, :t}},
        {404, {Gleanex.Admin.ErrorResponse, :t}}
      ],
      opts: opts
    })
  end
end
