defmodule Gleanex.Platform.Users do
  @moduledoc """
  Provides API endpoint related to users
  """

  @default_client Gleanex.HTTP

  @doc """
  List users

  List the users in the Glean directory, ordered by display_name and then by user_id. The list includes the same people as the Glean People directory. Inactive users, such as former employees, are left out unless an is_active filter includes the value "false". Use the returned user_id values with other Platform APIs, for example as usage limit targets.

  ## Options

    * `page_size`: Maximum number of users to return. Defaults to 50. Maximum is 100.
    * `cursor`: Opaque pagination cursor from a previous response. Send the same filters that the previous request used.
      
    * `filters`: JSON-encoded filters that choose which users are returned. The only supported field is is_active, with the values "true" and "false" and the operator EQUALS. Multiple values OR within a filter. Multiple filters AND together. Without an is_active filter, only active users are returned. To return active and inactive users, send [{"field":"is_active","values":["true","false"]}].
      
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
