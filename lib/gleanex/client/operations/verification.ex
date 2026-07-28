defmodule Gleanex.Client.Verification do
  @moduledoc """
  Provides API endpoints related to verification
  """

  @default_client Gleanex.HTTP

  @doc """
  Create verification

  Creates a verification reminder for the document. Users can create verification reminders from different product surfaces.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Details about the reminder.
  """
  @spec addverificationreminder(body :: Gleanex.Client.ReminderRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.Verification.t()} | {:error, Gleanex.Error.t()}
  def addverificationreminder(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Verification, :addverificationreminder},
      url: "/addverificationreminder",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.ReminderRequest, :t}}],
      response: [
        {200, {Gleanex.Client.Verification, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  List verifications

  Returns the information to be rendered in verification dashboard. Includes information for each document owned by user regarding their verifications.

  ## Options

    * `count`: Maximum number of documents to return
    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  """
  @spec listverifications(opts :: keyword) ::
          {:ok, Gleanex.Client.VerificationFeed.t()} | {:error, Gleanex.Error.t()}
  def listverifications(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:count, :locale])

    client.request(%{
      args: [],
      call: {Gleanex.Client.Verification, :listverifications},
      url: "/listverifications",
      method: :post,
      query: query,
      response: [
        {200, {Gleanex.Client.VerificationFeed, :t}},
        {400, :null},
        {401, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Update verification

  Verify documents to keep the knowledge up to date within customer corpus.

  ## Options

    * `locale`: The client's preferred locale in rfc5646 format (e.g. `en`, `ja`, `pt-BR`). If omitted, the `Accept-Language` will be used. If not present or not supported, defaults to the closest match or `en`.

  ## Request Body

  **Content Types**: `application/json`

  Details about the verification request.
  """
  @spec verify(body :: Gleanex.Client.VerifyRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Client.Verification.t()} | {:error, Gleanex.Error.t()}
  def verify(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:locale])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Verification, :verify},
      url: "/verify",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.VerifyRequest, :t}}],
      response: [
        {200, {Gleanex.Client.Verification, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @type t :: %__MODULE__{
          metadata: Gleanex.Client.VerificationMetadata.t() | nil,
          state: String.t()
        }

  defstruct [:metadata, :state]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      metadata: {Gleanex.Client.VerificationMetadata, :t},
      state: {:enum, ["UNVERIFIED", "VERIFIED", "DEPRECATED"]}
    ]
  end
end
