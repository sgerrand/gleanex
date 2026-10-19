defmodule Gleanex.Platform.Departments do
  @moduledoc """
  Provides API endpoints related to departments
  """

  @default_client Gleanex.HTTP

  @doc """
  Get a department

  Get one department by its department_id. Inactive departments are returned, so a caller can show the name of a department that a usage limit still names. A department is active when at least one active user belongs to it. A department is inactive when only inactive users, such as former employees, belong to it, or when only a usage limit names it. A department_id that is not valid, or that no user and no usage limit uses, returns 404 resource_not_found. A department_id comes from the exact department name, so a renamed department gets a new ID, and a name that is used again gets its old ID back.

  """
  @spec get(department_id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.GetDepartmentResponse.t()} | {:error, Gleanex.Error.t()}
  def get(department_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [department_id: department_id],
      call: {Gleanex.Platform.Departments, :get},
      url: "/departments/#{department_id}",
      method: :get,
      response: [
        {200, {Gleanex.Platform.GetDepartmentResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List departments

  List the departments in the Glean directory, ordered by display_name and then by department_id. A department is active when at least one active user belongs to it. A department is inactive when only inactive users, such as former employees, belong to it, or when only a usage limit names it. Inactive departments are left out unless an is_active filter includes the value "false". Department names are exact, so names that differ only by case are different departments.

  ## Options

    * `page_size`: Maximum number of departments to return. Defaults to 50. Maximum is 100.
    * `cursor`: Opaque pagination cursor from a previous response. Send the same filters that the previous request used.
      
    * `filters`: JSON-encoded filters that choose which departments are returned. The only supported field is is_active, with the values "true" and "false" and the operator EQUALS. Multiple values OR within a filter. Multiple filters AND together. Without an is_active filter, only active departments are returned. To return active and inactive departments, send [{"field":"is_active","values":["true","false"]}].
      

  """
  @spec list(opts :: keyword) ::
          {:ok, Gleanex.Platform.ListDepartmentsResponse.t()} | {:error, Gleanex.Error.t()}
  def list(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:cursor, :filters, :page_size])

    client.request(%{
      args: [],
      call: {Gleanex.Platform.Departments, :list},
      url: "/departments",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Platform.ListDepartmentsResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end
end
