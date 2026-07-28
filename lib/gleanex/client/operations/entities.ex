defmodule Gleanex.Client.Entities do
  @moduledoc """
  Provides API endpoints related to entities
  """

  @default_client Gleanex.HTTP

  @doc """
  Get person photo

  Returns the profile photo bytes for a person whose photo is stored in Glean (crawled from an identity source or user-uploaded via admin console). Photos hosted externally (e.g. Slack CDN) are not served by this endpoint; callers should follow the photoUrl from /people or /listentities directly. Responses include a Cache-Control header (max-age=3600) to reduce redundant fetches.

  ## Options

    * `ds`: Optional datasource override for crawled photos (e.g. AZURE, GDRIVE, OKTA). When omitted, the datasource is derived from the person's stored photo URL or the deployment's primary person datasource.
      

  """
  @spec get_person_photo(person_id :: String.t(), opts :: keyword) ::
          {:ok, binary} | {:error, Gleanex.Error.t()}
  def get_person_photo(person_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:ds])

    client.request(%{
      args: [person_id: person_id],
      call: {Gleanex.Client.Entities, :get_person_photo},
      url: "/people/#{person_id}/photo",
      method: :get,
      query: query,
      response: [
        {200, {:string, "binary"}},
        {400, :null},
        {401, :null},
        {404, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  List entities

  List some set of details for all entities that fit the given criteria and return in the requested order. Does not support negation in filters, assumes relation type EQUALS. There is a limit of 10000 entities that can be retrieved via this endpoint, except when using FULL_DIRECTORY request type for people entities.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  List people request
  """
  @spec listentities(body :: Gleanex.Client.ListEntitiesRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.ListEntitiesResponse.t()} | {:error, Gleanex.Error.t()}
  def listentities(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Entities, :listentities},
      url: "/listentities",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.ListEntitiesRequest, :t}}],
      response: [
        {200, {Gleanex.Client.ListEntitiesResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Read people

  Read people details for the given IDs.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  People request
  """
  @spec people(body :: Gleanex.Client.PeopleRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.PeopleResponse.t()} | {:error, Gleanex.Error.t()}
  def people(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Entities, :people},
      url: "/people",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.PeopleRequest, :t}}],
      response: [
        {200, {Gleanex.Client.PeopleResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end
end
