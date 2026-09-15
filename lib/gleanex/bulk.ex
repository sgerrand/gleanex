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
      fresh random ID, which nothing else reports, so pass your own if you want
      to be able to resume.
    * `:each` - a function of two arguments run after every page Glean accepts,
      receiving the response and a map describing the page. See below.
    * anything else is passed to the operation.

  An empty enumerable still sends one page, marked as both first and last, which
  is how an existing batch is emptied.

  ## Watching an upload go by

  Only the page count comes back at the end, so a long upload is otherwise
  silent, and whatever each page's response carried is gone. `:each` is called
  with that response and a map holding `:page`, counting from one, `:first?`,
  `:last?`, `:records` and `:upload_id`:

      Gleanex.Bulk.upload(
        config,
        &Gleanex.Indexing.Documents.bulkindexdocuments/2,
        %{datasource: "mydatasource"},
        :documents,
        documents,
        each: fn _response, page ->
          Logger.info("uploaded page \#{page.page}, \#{page.records} documents")
        end
      )

  It runs for accepted pages only, so it does not fire for the page that fails,
  and its return value is ignored. Anything it raises comes out of `upload/6`
  and leaves the upload uncommitted.
  """
  @spec upload(Config.t(), operation, map, atom, Enumerable.t(), keyword) ::
          {:ok, non_neg_integer} | {:error, Error.t()}
  def upload(%Config{} = config, operation, body, key, records, opts \\ [])
      when is_function(operation, 2) and is_map(body) and is_atom(key) do
    {page_size, opts} = Keyword.pop(opts, :page_size, @default_page_size)
    {upload_id, opts} = Keyword.pop_lazy(opts, :upload_id, &generate_upload_id/0)
    {each, opts} = Keyword.pop(opts, :each)
    each = callback!(each)
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
        {:ok, response} ->
          notify(each, response, %{
            page: sent + 1,
            first?: first?,
            last?: last?,
            records: length(page),
            upload_id: upload_id
          })

          {:cont, {:ok, sent + 1}}

        {:error, %Error{} = error} ->
          {:halt, {:error, error}}
      end
    end)
  end

  # Checked up front rather than at the first page, so a wrong shape fails
  # before any of the upload has been sent.
  defp callback!(nil), do: nil
  defp callback!(each) when is_function(each, 2), do: each

  defp callback!(other) do
    raise Error.usage(
            "expected :each to be a function of two arguments, got: #{inspect(other)}. It is " <>
              "called with the page's response and a map describing the page"
          )
  end

  defp notify(nil, _response, _page), do: :ok

  defp notify(each, response, page) do
    each.(response, page)
    :ok
  end

  # Chunks the records, tagging each page with whether it is the first and
  # whether it is the last. Needs one page of lookahead to know what is last,
  # so it does not hold the whole enumerable in memory.
  defp pages(records, page_size) do
    records
    |> Stream.chunk_every(page_size)
    |> Stream.concat([:end])
    |> Stream.transform({nil, true}, fn
      :end, {nil, true} ->
        {[{[], true, true}], :done}

      :end, {previous, first?} ->
        {[{previous, first?, true}], :done}

      chunk, {nil, first?} ->
        {[], {chunk, first?}}

      chunk, {previous, first?} ->
        {[{previous, first?, false}], {chunk, false}}
    end)
  end

  defp generate_upload_id do
    16 |> :crypto.strong_rand_bytes() |> Base.url_encode64(padding: false)
  end
end
