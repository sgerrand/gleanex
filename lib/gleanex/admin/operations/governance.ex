defmodule Gleanex.Admin.Governance do
  @moduledoc """
  Provides API endpoints related to governance
  """

  @default_client Gleanex.HTTP

  @doc """
  Creates findings export

  Creates a new DLP findings export job.

  ## Request Body

  **Content Types**: `application/json; charset=UTF-8`
  """
  @spec createfindingsexport(body :: Gleanex.Admin.DlpExportFindingsRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Admin.ExportInfo.t()} | {:error, Gleanex.Error.t()}
  def createfindingsexport(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Admin.Governance, :createfindingsexport},
      url: "/governance/data/findings/exports",
      body: body,
      method: :post,
      request: [{"application/json; charset=UTF-8", {Gleanex.Admin.DlpExportFindingsRequest, :t}}],
      response: [{200, {Gleanex.Admin.ExportInfo, :t}}, {403, :null}, {500, :null}],
      opts: opts
    })
  end

  @doc """
  Creates new policy

  Creates a new policy with specified specifications and returns its id.

  ## Request Body

  **Content Types**: `application/json; charset=UTF-8`
  """
  @spec createpolicy(body :: Gleanex.Admin.CreateDlpReportRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Admin.CreateDlpReportResponse.t()} | {:error, Gleanex.Error.t()}
  def createpolicy(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Admin.Governance, :createpolicy},
      url: "/governance/data/policies",
      body: body,
      method: :post,
      request: [{"application/json; charset=UTF-8", {Gleanex.Admin.CreateDlpReportRequest, :t}}],
      response: [{200, {Gleanex.Admin.CreateDlpReportResponse, :t}}, {403, :null}, {500, :null}],
      opts: opts
    })
  end

  @doc """
  Creates new one-time report

  Creates a new one-time report and executes its batch job.

  ## Request Body

  **Content Types**: `application/json; charset=UTF-8`
  """
  @spec createreport(body :: Gleanex.Admin.UpdateDlpConfigRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Admin.UpdateDlpConfigResponse.t()} | {:error, Gleanex.Error.t()}
  def createreport(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Admin.Governance, :createreport},
      url: "/governance/data/reports",
      body: body,
      method: :post,
      request: [{"application/json; charset=UTF-8", {Gleanex.Admin.UpdateDlpConfigRequest, :t}}],
      response: [{200, {Gleanex.Admin.UpdateDlpConfigResponse, :t}}, {403, :null}, {500, :null}],
      opts: opts
    })
  end

  @doc """
  Deletes findings export

  Deletes a DLP findings export.
  """
  @spec deletefindingsexport(id :: integer, opts :: keyword) :: :ok | {:error, Gleanex.Error.t()}
  def deletefindingsexport(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Gleanex.Admin.Governance, :deletefindingsexport},
      url: "/governance/data/findings/exports/#{id}",
      method: :delete,
      response: [{200, :null}, {403, :null}, {500, :null}],
      opts: opts
    })
  end

  @doc """
  Downloads findings export

  Downloads a DLP findings export as a CSV file.
  """
  @spec downloadfindingsexport(id :: String.t(), opts :: keyword) ::
          {:ok, String.t()} | {:error, Gleanex.Error.t()}
  def downloadfindingsexport(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Gleanex.Admin.Governance, :downloadfindingsexport},
      url: "/governance/data/findings/exports/#{id}",
      method: :get,
      response: [{200, :string}, {403, :null}, {500, :null}],
      opts: opts
    })
  end

  @doc """
  Downloads violations CSV for policy

  Downloads CSV violations report for a specific policy id. This does not support continuous policies.
  """
  @spec downloadpolicycsv(id :: String.t(), opts :: keyword) ::
          {:ok, String.t()} | {:error, Gleanex.Error.t()}
  def downloadpolicycsv(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Gleanex.Admin.Governance, :downloadpolicycsv},
      url: "/governance/data/policies/#{id}/download",
      method: :get,
      response: [{200, :string}, {400, :null}, {403, :null}, {500, :null}],
      opts: opts
    })
  end

  @doc """
  Downloads violations CSV for report

  Downloads CSV violations report for a specific report id.
  """
  @spec downloadreportcsv(id :: String.t(), opts :: keyword) ::
          {:ok, String.t()} | {:error, Gleanex.Error.t()}
  def downloadreportcsv(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Gleanex.Admin.Governance, :downloadreportcsv},
      url: "/governance/data/reports/#{id}/download",
      method: :get,
      response: [{200, :string}, {403, :null}, {500, :null}],
      opts: opts
    })
  end

  @doc """
  Fetches documents visibility

  Fetches the visibility override status of the documents passed.

  ## Options

    * `docIds`: List of doc-ids which will have their hide status fetched.

  """
  @spec getdocvisibility(opts :: keyword) ::
          {:ok, Gleanex.Admin.GetDocumentVisibilityOverridesResponse.t()}
          | {:error, Gleanex.Error.t()}
  def getdocvisibility(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:docIds])

    client.request(%{
      args: [],
      call: {Gleanex.Admin.Governance, :getdocvisibility},
      url: "/governance/documents/visibilityoverrides",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Admin.GetDocumentVisibilityOverridesResponse, :t}},
        {403, :null},
        {500, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Gets specified policy

  Fetches the specified policy version, or the latest if no version is provided.

  ## Options

    * `version`: The version of the policy to fetch. Each time a policy is updated, the older version is still stored. If this is left empty, the latest policy is fetched.

  """
  @spec getpolicy(id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Admin.GetDlpReportResponse.t()} | {:error, Gleanex.Error.t()}
  def getpolicy(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:version])

    client.request(%{
      args: [id: id],
      call: {Gleanex.Admin.Governance, :getpolicy},
      url: "/governance/data/policies/#{id}",
      method: :get,
      query: query,
      response: [{200, {Gleanex.Admin.GetDlpReportResponse, :t}}, {403, :null}, {500, :null}],
      opts: opts
    })
  end

  @doc """
  Fetches report run status

  Fetches the status of the run corresponding to the report-id.
  """
  @spec getreportstatus(id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Admin.ReportStatusResponse.t()} | {:error, Gleanex.Error.t()}
  def getreportstatus(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Gleanex.Admin.Governance, :getreportstatus},
      url: "/governance/data/reports/#{id}/status",
      method: :get,
      response: [{200, {Gleanex.Admin.ReportStatusResponse, :t}}, {403, :null}, {500, :null}],
      opts: opts
    })
  end

  @doc """
  Lists findings exports

  Lists all DLP findings exports.
  """
  @spec listfindingsexports(opts :: keyword) ::
          {:ok, Gleanex.Admin.ListDlpFindingsExportsResponse.t()} | {:error, Gleanex.Error.t()}
  def listfindingsexports(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Gleanex.Admin.Governance, :listfindingsexports},
      url: "/governance/data/findings/exports",
      method: :get,
      response: [
        {200, {Gleanex.Admin.ListDlpFindingsExportsResponse, :t}},
        {403, :null},
        {500, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Lists policies

  Lists policies with filtering.

  ## Options

    * `autoHide`: Filter to return reports with a given value of auto-hide.
    * `frequency`: Filter to return reports with a given frequency.

  """
  @spec listpolicies(opts :: keyword) ::
          {:ok, Gleanex.Admin.ListDlpReportsResponse.t()} | {:error, Gleanex.Error.t()}
  def listpolicies(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:autoHide, :frequency])

    client.request(%{
      args: [],
      call: {Gleanex.Admin.Governance, :listpolicies},
      url: "/governance/data/policies",
      method: :get,
      query: query,
      response: [{200, {Gleanex.Admin.ListDlpReportsResponse, :t}}, {403, :null}, {500, :null}],
      opts: opts
    })
  end

  @doc """
  Hide or unhide docs

  Sets the visibility-override state of the documents specified, effectively hiding or un-hiding documents.

  ## Request Body

  **Content Types**: `application/json; charset=UTF-8`
  """
  @spec setdocvisibility(
          body :: Gleanex.Admin.UpdateDocumentVisibilityOverridesRequest.t(),
          opts :: keyword
        ) ::
          {:ok, Gleanex.Admin.UpdateDocumentVisibilityOverridesResponse.t()}
          | {:error, Gleanex.Error.t()}
  def setdocvisibility(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Admin.Governance, :setdocvisibility},
      url: "/governance/documents/visibilityoverrides",
      body: body,
      method: :post,
      request: [
        {"application/json; charset=UTF-8",
         {Gleanex.Admin.UpdateDocumentVisibilityOverridesRequest, :t}}
      ],
      response: [
        {200, {Gleanex.Admin.UpdateDocumentVisibilityOverridesResponse, :t}},
        {403, :null},
        {500, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Updates an existing policy

  Updates an existing policy.

  ## Request Body

  **Content Types**: `application/json; charset=UTF-8`
  """
  @spec updatepolicy(
          id :: String.t(),
          body :: Gleanex.Admin.UpdateDlpReportRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Admin.UpdateDlpReportResponse.t()} | {:error, Gleanex.Error.t()}
  def updatepolicy(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Gleanex.Admin.Governance, :updatepolicy},
      url: "/governance/data/policies/#{id}",
      body: body,
      method: :post,
      request: [{"application/json; charset=UTF-8", {Gleanex.Admin.UpdateDlpReportRequest, :t}}],
      response: [{200, {Gleanex.Admin.UpdateDlpReportResponse, :t}}, {403, :null}, {500, :null}],
      opts: opts
    })
  end
end
