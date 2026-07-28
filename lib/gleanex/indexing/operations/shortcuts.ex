defmodule Gleanex.Indexing.Shortcuts do
  @moduledoc """
  Provides API endpoints related to shortcuts
  """

  @default_client Gleanex.HTTP

  @doc """
  Bulk index external shortcuts

  Replaces all the currently indexed shortcuts using paginated batch API calls. Note that this endpoint is used for indexing shortcuts not hosted by Glean. If you want to upload shortcuts that would be hosted by Glean, please use the `/uploadshortcuts` endpoint. For information on what you can do with Golinks, which are Glean-hosted shortcuts, please refer to [this](https://docs.glean.com/user-guide/knowledge/go-links/how-go-links-work) page.

  ## Request Body

  **Content Types**: `application/json; charset=UTF-8`
  """
  @spec bulkindexshortcuts(
          body :: Gleanex.Indexing.BulkIndexShortcutsRequest.t(),
          opts :: keyword
        ) :: :ok | {:error, Gleanex.Error.t()}
  def bulkindexshortcuts(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Shortcuts, :bulkindexshortcuts},
      url: "/bulkindexshortcuts",
      body: body,
      method: :post,
      request: [
        {"application/json; charset=UTF-8", {Gleanex.Indexing.BulkIndexShortcutsRequest, :t}}
      ],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Upload shortcuts

  Creates glean shortcuts for uploaded shortcuts info. Glean would host the shortcuts, and they can be managed in the knowledge tab once uploaded.

  ## Request Body

  **Content Types**: `application/json; charset=UTF-8`
  """
  @spec uploadshortcuts(body :: Gleanex.Indexing.UploadShortcutsRequest.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def uploadshortcuts(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Indexing.Shortcuts, :uploadshortcuts},
      url: "/uploadshortcuts",
      body: body,
      method: :post,
      request: [
        {"application/json; charset=UTF-8", {Gleanex.Indexing.UploadShortcutsRequest, :t}}
      ],
      response: [{200, :null}, {400, :null}, {401, :null}, {409, :null}],
      opts: opts
    })
  end
end
