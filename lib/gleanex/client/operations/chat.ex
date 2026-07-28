defmodule Gleanex.Client.Chat do
  @moduledoc """
  Provides API endpoints related to chat
  """

  @default_client Gleanex.HTTP

  @doc """
  Chat

  Have a conversation with Glean AI.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.
    * `timezoneOffset`: The offset of the client's timezone in minutes from UTC. e.g. PDT is -420 because it's 7 hours behind UTC.

  ## Request Body

  **Content Types**: `application/json`

  Includes chat history for Glean AI to respond to.
  """
  @spec chat(body :: Gleanex.Client.ChatRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.ChatResponse.t()} | {:error, Gleanex.Error.t()}
  def chat(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale, :timezoneOffset])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Chat, :chat},
      url: "/chat",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.ChatRequest, :t}}],
      response: [
        {200, {Gleanex.Client.ChatResponse, :t}},
        {202, {Gleanex.Client.ChatResponse, :t}},
        {400, :null},
        {401, :null},
        {408, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Deletes all saved Chats owned by a user

  Deletes all saved Chats a user has had and all their contained conversational content.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.
    * `timezoneOffset`: The offset of the client's timezone in minutes from UTC. e.g. PDT is -420 because it's 7 hours behind UTC.

  """
  @spec deleteallchats(opts :: keyword) :: :ok | {:error, Gleanex.Error.t()}
  def deleteallchats(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale, :timezoneOffset])

    client.request(%{
      args: [],
      call: {Gleanex.Client.Chat, :deleteallchats},
      url: "/deleteallchats",
      method: :post,
      query: query,
      response: [{200, :null}, {400, :null}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Delete files uploaded by a user for chat

  Delete files uploaded by a user for Chat.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.
    * `timezoneOffset`: The offset of the client's timezone in minutes from UTC. e.g. PDT is -420 because it's 7 hours behind UTC.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec deletechatfiles(body :: Gleanex.Client.DeleteChatFilesRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def deletechatfiles(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale, :timezoneOffset])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Chat, :deletechatfiles},
      url: "/deletechatfiles",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.DeleteChatFilesRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {403, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Deletes saved Chats

  Deletes saved Chats and all their contained conversational content.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.
    * `timezoneOffset`: The offset of the client's timezone in minutes from UTC. e.g. PDT is -420 because it's 7 hours behind UTC.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec deletechats(body :: Gleanex.Client.DeleteChatsRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def deletechats(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale, :timezoneOffset])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Chat, :deletechats},
      url: "/deletechats",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.DeleteChatsRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {403, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Download a chat file

  Download the raw content of a file generated or uploaded during a chat session (for example, an image produced by the assistant). Returns the file bytes with a Content-Type header matching the file's MIME type.

  ## Options

    * `preview`: When true and the file is a PDF, the response is served inline (Content-Disposition: inline) instead of as an attachment.
      

  """
  @spec get_chat_file(fileId :: String.t(), opts :: keyword) ::
          {:ok, binary} | {:error, Gleanex.Error.t()}
  def get_chat_file(fileId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:preview])

    client.request(%{
      args: [fileId: fileId],
      call: {Gleanex.Client.Chat, :get_chat_file},
      url: "/chat-files/#{fileId}",
      method: :get,
      query: query,
      response: [
        {200, {:string, "binary"}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null},
        {500, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Retrieves a Chat

  Retrieves the chat history between Glean Assistant and the user for a given Chat.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.
    * `timezoneOffset`: The offset of the client's timezone in minutes from UTC. e.g. PDT is -420 because it's 7 hours behind UTC.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec getchat(body :: Gleanex.Client.GetChatRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.GetChatResponse.t()} | {:error, Gleanex.Error.t()}
  def getchat(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale, :timezoneOffset])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Chat, :getchat},
      url: "/getchat",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.GetChatRequest, :t}}],
      response: [
        {200, {Gleanex.Client.GetChatResponse, :t}},
        {400, :null},
        {401, :null},
        {403, {Gleanex.Client.AccessRequestPermissionDeniedResponse, :t}},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Gets the metadata for a custom Chat application

  Gets the Chat application details for the specified application ID.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.
    * `timezoneOffset`: The offset of the client's timezone in minutes from UTC. e.g. PDT is -420 because it's 7 hours behind UTC.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec getchatapplication(body :: Gleanex.Client.GetChatApplicationRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.GetChatApplicationResponse.t()} | {:error, Gleanex.Error.t()}
  def getchatapplication(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale, :timezoneOffset])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Chat, :getchatapplication},
      url: "/getchatapplication",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.GetChatApplicationRequest, :t}}],
      response: [
        {200, {Gleanex.Client.GetChatApplicationResponse, :t}},
        {400, :null},
        {401, :null},
        {403, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get files uploaded by a user for Chat

  Get files uploaded by a user for Chat.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.
    * `timezoneOffset`: The offset of the client's timezone in minutes from UTC. e.g. PDT is -420 because it's 7 hours behind UTC.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec getchatfiles(body :: Gleanex.Client.GetChatFilesRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.GetChatFilesResponse.t()} | {:error, Gleanex.Error.t()}
  def getchatfiles(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale, :timezoneOffset])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Chat, :getchatfiles},
      url: "/getchatfiles",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.GetChatFilesRequest, :t}}],
      response: [
        {200, {Gleanex.Client.GetChatFilesResponse, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Retrieves all saved Chats

  Retrieves all the saved Chats between Glean Assistant and the user. The returned Chats contain only metadata and no conversational content.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.
    * `timezoneOffset`: The offset of the client's timezone in minutes from UTC. e.g. PDT is -420 because it's 7 hours behind UTC.

  """
  @spec listchats(opts :: keyword) ::
          {:ok, Gleanex.Client.ListChatsResponse.t()} | {:error, Gleanex.Error.t()}
  def listchats(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale, :timezoneOffset])

    client.request(%{
      args: [],
      call: {Gleanex.Client.Chat, :listchats},
      url: "/listchats",
      method: :post,
      query: query,
      response: [
        {200, {Gleanex.Client.ListChatsResponse, :t}},
        {401, :null},
        {403, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Upload files for Chat

  Upload files for Chat.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.
    * `timezoneOffset`: The offset of the client's timezone in minutes from UTC. e.g. PDT is -420 because it's 7 hours behind UTC.

  ## Request Body

  **Content Types**: `multipart/form-data`
  """
  @spec uploadchatfiles(body :: Gleanex.Client.UploadChatFilesRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.UploadChatFilesResponse.t()} | {:error, Gleanex.Error.t()}
  def uploadchatfiles(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale, :timezoneOffset])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Chat, :uploadchatfiles},
      url: "/uploadchatfiles",
      body: body,
      method: :post,
      query: query,
      request: [{"multipart/form-data", {Gleanex.Client.UploadChatFilesRequest, :t}}],
      response: [
        {200, {Gleanex.Client.UploadChatFilesResponse, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @type t :: %__MODULE__{
          applicationId: String.t() | nil,
          applicationName: String.t() | nil,
          createTime: integer | nil,
          createdBy: Gleanex.Client.Person.t() | nil,
          icon: Gleanex.Client.IconConfig.t() | nil,
          id: String.t() | nil,
          name: String.t() | nil,
          permissions: Gleanex.Client.ObjectPermissions.t() | nil,
          updateTime: integer | nil
        }

  defstruct [
    :applicationId,
    :applicationName,
    :createTime,
    :createdBy,
    :icon,
    :id,
    :name,
    :permissions,
    :updateTime
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      applicationId: :string,
      applicationName: :string,
      createTime: :integer,
      createdBy: {Gleanex.Client.Person, :t},
      icon: {Gleanex.Client.IconConfig, :t},
      id: :string,
      name: :string,
      permissions: {Gleanex.Client.ObjectPermissions, :t},
      updateTime: :integer
    ]
  end
end
