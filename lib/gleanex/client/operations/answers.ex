defmodule Gleanex.Client.Answers do
  @moduledoc """
  Provides API endpoints related to answers
  """

  @default_client Gleanex.HTTP

  @doc """
  Create Answer

  Create a user-generated Answer that contains a question and answer.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  CreateAnswer request
  """
  @spec createanswer(body :: Gleanex.Client.CreateAnswerRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.Answer.t()} | {:error, Gleanex.Error.t()}
  def createanswer(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Answers, :createanswer},
      url: "/createanswer",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.CreateAnswerRequest, :t}}],
      response: [{200, {Gleanex.Client.Answer, :t}}, {400, :null}, {401, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Delete Answer

  Delete an existing user-generated Answer.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  DeleteAnswer request
  """
  @spec deleteanswer(body :: Gleanex.Client.DeleteAnswerRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def deleteanswer(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Answers, :deleteanswer},
      url: "/deleteanswer",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.DeleteAnswerRequest, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Update Answer

  Update an existing user-generated Answer.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  EditAnswer request
  """
  @spec editanswer(body :: Gleanex.Client.EditAnswerRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.Answer.t()} | {:error, Gleanex.Error.t()}
  def editanswer(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Answers, :editanswer},
      url: "/editanswer",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.EditAnswerRequest, :t}}],
      response: [{200, {Gleanex.Client.Answer, :t}}, {400, :null}, {401, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Read Answer

  Read the details of a particular Answer given its ID.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  GetAnswer request
  """
  @spec getanswer(body :: Gleanex.Client.GetAnswerRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.GetAnswerResponse.t()} | {:error, Gleanex.Error.t()}
  def getanswer(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Answers, :getanswer},
      url: "/getanswer",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.GetAnswerRequest, :t}}],
      response: [
        {200, {Gleanex.Client.GetAnswerResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  List Answers

  List Answers created by the current user.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  ListAnswers request
  """
  @spec listanswers(body :: Gleanex.Client.ListAnswersRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.ListAnswersResponse.t()} | {:error, Gleanex.Error.t()}
  def listanswers(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Answers, :listanswers},
      url: "/listanswers",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.ListAnswersRequest, :t}}],
      response: [
        {200, {Gleanex.Client.ListAnswersResponse, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end
end
