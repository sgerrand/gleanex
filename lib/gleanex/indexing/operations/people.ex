defmodule Gleanex.Indexing.People do
  @moduledoc """
  Provides API endpoints related to people
  """

  @default_client Gleanex.HTTP

  @doc """
  Bulk index employees

  Replaces all the currently indexed employees using paginated batch API calls. Please refer to the [bulk indexing](https://developers.glean.com/indexing/documents/bulk-upload-model) documentation for an explanation of how to use bulk endpoints.

  ## Request Body

  **Content Types**: `application/json; charset=UTF-8`
  """
  @spec bulkindexemployees(
          body :: Gleanex.Indexing.BulkIndexEmployeesRequest.t(),
          opts :: keyword
        ) :: :ok | {:error, Gleanex.Error.t()}
  def bulkindexemployees(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.People, :bulkindexemployees},
      url: "/bulkindexemployees",
      body: body,
      method: :post,
      request: [
        {"application/json; charset=UTF-8", {Gleanex.Indexing.BulkIndexEmployeesRequest, :t}}
      ],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Bulk index teams

  Replaces all the currently indexed teams using paginated batch API calls. Please refer to the [bulk indexing](https://developers.glean.com/indexing/documents/bulk-upload-model) documentation for an explanation of how to use bulk endpoints.

  ## Request Body

  **Content Types**: `application/json; charset=UTF-8`
  """
  @spec bulkindexteams(body :: Gleanex.Indexing.BulkIndexTeamsRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def bulkindexteams(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.People, :bulkindexteams},
      url: "/bulkindexteams",
      body: body,
      method: :post,
      request: [{"application/json; charset=UTF-8", {Gleanex.Indexing.BulkIndexTeamsRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Delete employee

  Delete an employee. Silently succeeds if employee is not present.

  ## Request Body

  **Content Types**: `application/json; charset=UTF-8`
  """
  @spec deleteemployee(body :: Gleanex.Indexing.DeleteEmployeeRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def deleteemployee(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.People, :deleteemployee},
      url: "/deleteemployee",
      body: body,
      method: :post,
      request: [{"application/json; charset=UTF-8", {Gleanex.Indexing.DeleteEmployeeRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Delete team

  Delete a team based on provided id.

  ## Request Body

  **Content Types**: `application/json; charset=UTF-8`
  """
  @spec deleteteam(body :: Gleanex.Indexing.DeleteTeamRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def deleteteam(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.People, :deleteteam},
      url: "/deleteteam",
      body: body,
      method: :post,
      request: [{"application/json; charset=UTF-8", {Gleanex.Indexing.DeleteTeamRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Index employee

  Adds an employee or replaces the existing information about an employee.

  ## Request Body

  **Content Types**: `application/json; charset=UTF-8`
  """
  @spec indexemployee(body :: Gleanex.Indexing.IndexEmployeeRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def indexemployee(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.People, :indexemployee},
      url: "/indexemployee",
      body: body,
      method: :post,
      request: [{"application/json; charset=UTF-8", {Gleanex.Indexing.IndexEmployeeRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Bulk index employees

  Bulk upload details of all the employees. This deletes all employees uploaded in the prior batch. SOON TO BE DEPRECATED in favor of /bulkindexemployees.

  ## Request Body

  **Content Types**: `application/json; charset=UTF-8`
  """
  @spec indexemployeelist(body :: Gleanex.Indexing.IndexEmployeeListRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def indexemployeelist(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.People, :indexemployeelist},
      url: "/indexemployeelist",
      body: body,
      method: :post,
      request: [
        {"application/json; charset=UTF-8", {Gleanex.Indexing.IndexEmployeeListRequest, :t}}
      ],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Index team

  Adds a team or updates information about a team

  ## Request Body

  **Content Types**: `application/json; charset=UTF-8`
  """
  @spec indexteam(body :: Gleanex.Indexing.IndexTeamRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def indexteam(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.People, :indexteam},
      url: "/indexteam",
      body: body,
      method: :post,
      request: [{"application/json; charset=UTF-8", {Gleanex.Indexing.IndexTeamRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Schedules the processing of uploaded employees and teams

  Schedules the immediate processing of employees and teams uploaded through the indexing API. By default all uploaded people data will be processed asynchronously but this API can be used to schedule its processing on demand.

  """
  @spec processallemployeesandteams(opts :: keyword) :: :ok | {:error, Gleanex.Error.t()}
  def processallemployeesandteams(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Gleanex.Indexing.People, :processallemployeesandteams},
      url: "/processallemployeesandteams",
      method: :post,
      response: [{200, :null}, {400, :null}, {401, :null}, {429, :null}],
      opts: opts
    })
  end
end
