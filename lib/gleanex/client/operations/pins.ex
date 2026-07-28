defmodule Gleanex.Client.Pins do
  @moduledoc """
  Provides API endpoints related to pins
  """

  @default_client Gleanex.HTTP

  @doc """
  Update pin

  Update an existing user-generated pin.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Edit pins request
  """
  @spec editpin(body :: Gleanex.Client.EditPinRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.PinDocument.t()} | {:error, Gleanex.Error.t()}
  def editpin(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Pins, :editpin},
      url: "/editpin",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.EditPinRequest, :t}}],
      response: [
        {200, {Gleanex.Client.PinDocument, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Read pin

  Read pin details given its ID.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Get pin request
  """
  @spec getpin(body :: Gleanex.Client.GetPinRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.GetPinResponse.t()} | {:error, Gleanex.Error.t()}
  def getpin(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Pins, :getpin},
      url: "/getpin",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.GetPinRequest, :t}}],
      response: [
        {200, {Gleanex.Client.GetPinResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  List pins

  Lists all pins.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  List pins request
  """
  @spec listpins(body :: map, opts :: keyword) ::
          {:ok, Gleanex.Client.ListPinsResponse.t()} | {:error, Gleanex.Error.t()}
  def listpins(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Pins, :listpins},
      url: "/listpins",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", :map}],
      response: [
        {200, {Gleanex.Client.ListPinsResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Create pin

  Pin a document as a result for a given search query.Pin results that are known to be a good match.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Details about the document and query for the pin.
  """
  @spec pin(body :: Gleanex.Client.PinRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.PinDocument.t()} | {:error, Gleanex.Error.t()}
  def pin(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Pins, :pin},
      url: "/pin",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.PinRequest, :t}}],
      response: [
        {200, {Gleanex.Client.PinDocument, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Delete pin

  Unpin a previously pinned result.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Details about the pin being unpinned.
  """
  @spec unpin(body :: Gleanex.Client.Unpin.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def unpin(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Pins, :unpin},
      url: "/unpin",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.Unpin, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {403, :null}, {429, :null}],
      opts: opts
    })
  end
end
