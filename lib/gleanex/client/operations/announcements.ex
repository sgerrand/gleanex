defmodule Gleanex.Client.Announcements do
  @moduledoc """
  Provides API endpoints related to announcements
  """

  @default_client Gleanex.HTTP

  @doc """
  Create Announcement

  Create a textual announcement visible to some set of users based on department and location.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Announcement content
  """
  @spec createannouncement(body :: Gleanex.Client.CreateAnnouncementRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.Announcement.t()} | {:error, Gleanex.Error.t()}
  def createannouncement(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Announcements, :createannouncement},
      url: "/createannouncement",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.CreateAnnouncementRequest, :t}}],
      response: [
        {200, {Gleanex.Client.Announcement, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Delete Announcement

  Delete an existing user-generated announcement.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Delete announcement request
  """
  @spec deleteannouncement(body :: Gleanex.Client.DeleteAnnouncementRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def deleteannouncement(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Announcements, :deleteannouncement},
      url: "/deleteannouncement",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.DeleteAnnouncementRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Update Announcement

  Update a textual announcement visible to some set of users based on department and location.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Announcement content. Id need to be specified for the announcement.
  """
  @spec updateannouncement(body :: Gleanex.Client.UpdateAnnouncementRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.Announcement.t()} | {:error, Gleanex.Error.t()}
  def updateannouncement(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Announcements, :updateannouncement},
      url: "/updateannouncement",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.UpdateAnnouncementRequest, :t}}],
      response: [
        {200, {Gleanex.Client.Announcement, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end
end
