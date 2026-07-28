defmodule Gleanex.Client.Shortcuts do
  @moduledoc """
  Provides API endpoints related to shortcuts
  """

  @default_client Gleanex.HTTP

  @doc """
  Create shortcut

  Create a user-generated shortcut that contains an alias and destination URL.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  CreateShortcut request
  """
  @spec createshortcut(body :: Gleanex.Client.CreateShortcutRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.CreateShortcutResponse.t()} | {:error, Gleanex.Error.t()}
  def createshortcut(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Shortcuts, :createshortcut},
      url: "/createshortcut",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.CreateShortcutRequest, :t}}],
      response: [
        {200, {Gleanex.Client.CreateShortcutResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Delete shortcut

  Delete an existing user-generated shortcut.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  DeleteShortcut request
  """
  @spec deleteshortcut(body :: Gleanex.Client.DeleteShortcutRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def deleteshortcut(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Shortcuts, :deleteshortcut},
      url: "/deleteshortcut",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.DeleteShortcutRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Read shortcut

  Read a particular shortcut's details given its ID.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  GetShortcut request
  """
  @spec getshortcut(body :: map | Gleanex.Client.UserGeneratedContentId.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.GetShortcutResponse.t()} | {:error, Gleanex.Error.t()}
  def getshortcut(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Shortcuts, :getshortcut},
      url: "/getshortcut",
      body: body,
      method: :post,
      query: query,
      request: [
        {"application/json", {:union, [:map, {Gleanex.Client.UserGeneratedContentId, :t}]}}
      ],
      response: [
        {200, {Gleanex.Client.GetShortcutResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  List shortcuts

  List shortcuts editable/owned by the currently authenticated user.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Filters, sorters, paging params required for pagination
  """
  @spec listshortcuts(body :: Gleanex.Client.ListShortcutsPaginatedRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.ListShortcutsPaginatedResponse.t()} | {:error, Gleanex.Error.t()}
  def listshortcuts(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Shortcuts, :listshortcuts},
      url: "/listshortcuts",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.ListShortcutsPaginatedRequest, :t}}],
      response: [
        {200, {Gleanex.Client.ListShortcutsPaginatedResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Update shortcut

  Updates the shortcut with the given ID.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Shortcut content. Id need to be specified for the shortcut.
  """
  @spec updateshortcut(body :: Gleanex.Client.UpdateShortcutRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.UpdateShortcutResponse.t()} | {:error, Gleanex.Error.t()}
  def updateshortcut(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Shortcuts, :updateshortcut},
      url: "/updateshortcut",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.UpdateShortcutRequest, :t}}],
      response: [
        {200, {Gleanex.Client.UpdateShortcutResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end
end
