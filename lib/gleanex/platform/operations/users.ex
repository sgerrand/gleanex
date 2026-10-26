defmodule Gleanex.Platform.Users do
  @moduledoc """
  Provides API endpoints related to users
  """

  @default_client Gleanex.HTTP

  @doc """
  Get user

  Get one user in the Glean directory by user_id. The user can be any person that the list returns. A user_id that is not in the directory returns 404 resource_not_found. This includes a deleted user and a person that the People directory does not show. An alias ID of a merged person returns the person's canonical user_id.

  ## Options

    * `include`: Optional fields to add to the user. Each value only adds fields.
      

  """
  @spec get(user_id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.GetUserResponse.t()} | {:error, Gleanex.Error.t()}
  def get(user_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:include])

    client.request(%{
      args: [user_id: user_id],
      call: {Gleanex.Platform.Users, :get},
      url: "/users/#{user_id}",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Platform.GetUserResponse, :t}},
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
  List users

  List the users in the Glean directory, ordered by display_name and then by user_id. The list includes the same people as the Glean People directory. Filter by name, email, manager_id, or department_id to find specific users. Use the returned user_id values with other Platform APIs, for example as usage limit targets.

  ## Options

    * `page_size`: Maximum number of users to return. Defaults to 50. Maximum is 100.
    * `cursor`: Opaque pagination cursor from a previous response. Send the same filters that the previous request used.
      
    * `filters`: JSON-encoded filters that choose which users are returned. The supported fields are name, email, manager_id, and department_id, each with the operator EQUALS. Multiple values OR within a filter. Multiple filters AND together. Each field may appear in only one filter. A value that matches no user, such as an unknown email or department_id, returns no users rather than an error.
      
    * `include`: Optional fields to add to each user. Each value only adds fields; it does not change which users are returned.
      

  """
  @spec list(opts :: keyword) ::
          {:ok, Gleanex.Platform.ListUsersResponse.t()} | {:error, Gleanex.Error.t()}
  def list(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:cursor, :filters, :include, :page_size])

    client.request(%{
      args: [],
      call: {Gleanex.Platform.Users, :list},
      url: "/users",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Platform.ListUsersResponse, :t}},
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
