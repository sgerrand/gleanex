defmodule Gleanex.Bulk do
  @moduledoc """
  Drive Glean's paged bulk indexing protocol.

  Every `/bulkindex*` endpoint works the same way. You upload records in pages,
  and each request carries:

    * `uploadId` - the same value on every page of one upload
    * `isFirstPage` - `true` on the first page, which starts a fresh upload
    * `isLastPage` - `true` on the last page, which commits it

  Committing matters: a bulk upload replaces everything uploaded in the previous
  batch, and Glean only swaps the batch in once it has seen the last page. An
  upload that stops halfway leaves the previous batch in place.

  ## Examples

      Gleanex.Bulk.upload(
        config,
        &Gleanex.Indexing.Documents.bulkindexdocuments/2,
        %{datasource: "mydatasource"},
        :documents,
        documents
      )

      Gleanex.Bulk.upload(
        config,
        &Gleanex.Indexing.Permissions.bulkindexusers/2,
        %{datasource: "mydatasource"},
        :users,
        users,
        page_size: 500
      )

  """

  alias Gleanex.Config
  alias Gleanex.Error

  @default_page_size 100

  @typedoc "A generated bulk indexing operation."
  @type operation :: (map, keyword -> {:ok, term} | {:error, Error.t()})

  @doc """
  Upload an enumerable in pages.

  Returns `{:ok, page_count}`, or `{:error, %Gleanex.Error{}}` for the first page
  that fails. Later pages are not attempted after a failure, which leaves the
  upload uncommitted and the previous batch intact.

  `body` supplies the fields shared by every page, most importantly
  `:datasource`. `key` is the field holding the records, for example
  `:documents` or `:users`.

  ## Options

    * `:page_size` - records per request, default `#{@default_page_size}`.
    * `:upload_id` - reuse an ID to resume an interrupted upload. Defaults to a
      fresh random ID.
    * anything else is passed to the operation.

  An empty enumerable still sends one page, marked as both first and last, which
  is how an existing batch is emptied.
  """
  @spec upload(Config.t(), operation, map, atom, Enumerable.t(), keyword) ::
          {:ok, non_neg_integer} | {:error, Error.t()}
  def upload(%Config{} = config, operation, body, key, records, opts \\ [])
      when is_function(operation, 2) and is_map(body) and is_atom(key) do
    {page_size, opts} = Keyword.pop(opts, :page_size, @default_page_size)
    {upload_id, opts} = Keyword.pop_lazy(opts, :upload_id, &generate_upload_id/0)
    opts = Keyword.put(opts, :config, config)

    records
    |> pages(page_size)
    |> Enum.reduce_while({:ok, 0}, fn {page, first?, last?}, {:ok, sent} ->
      page_body =
        body
        |> Map.put(key, page)
        |> Map.put(:uploadId, upload_id)
        |> Map.put(:isFirstPage, first?)
        |> Map.put(:isLastPage, last?)

      case operation.(page_body, opts) do
        {:ok, _response} -> {:cont, {:ok, sent + 1}}
        {:error, %Error{} = error} -> {:halt, {:error, error}}
      end
    end)
  end

  # Chunks the records, tagging each page with whether it is the first and
  # whether it is the last. Needs one page of lookahead to know what is last,
  # so it does not hold the whole enumerable in memory.
  defp pages(records, page_size) do
    records
    |> Stream.chunk_every(page_size)
    |> Stream.concat([:end])
    |> Stream.transform({nil, 0}, fn
      :end, {nil, 0} ->
        {[{[], true, true}], :done}

      :end, {previous, index} ->
        {[{previous, index == 0, true}], :done}

      chunk, {nil, 0} ->
        {[], {chunk, 0}}

      chunk, {previous, index} ->
        {[{previous, index == 0, false}], {chunk, index + 1}}
    end)
  end

  defp generate_upload_id do
    16 |> :crypto.strong_rand_bytes() |> Base.url_encode64(padding: false)
  end
end
