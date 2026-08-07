defmodule Gleanex.Pagination do
  @moduledoc """
  Walk Glean's cursor-paginated endpoints.

  Glean paginates the same way across `/search`, `/listentities`, `/listchats`
  and `/getdocumentsbyfacets`: the response carries a `cursor` and, on some
  endpoints, `hasMoreResults`. Sending that cursor back in the next request body
  fetches the following page.

  The generated operations do one request each, so this module drives the loop.

  ## Examples

      config = Gleanex.new(domain: "mycompany", token: token)

      config
      |> Gleanex.Pagination.stream(&Gleanex.Client.Search.search/2, %{query: "holidays"})
      |> Stream.flat_map(& &1.results)
      |> Enum.take(100)

  Pages come back as whole responses, so metadata such as `trackingToken` is not
  thrown away. Use `stream_items/5` when only the records matter:

      Gleanex.Pagination.stream_items(
        config,
        &Gleanex.Client.Entities.listentities/2,
        %{entityType: "PEOPLE"},
        :results
      )

  ## Errors

  A failed page raises the `Gleanex.Error` it produced. Lazy enumerables have
  nowhere to put an error tuple without making every element a tuple, and
  silently ending the stream would look exactly like reaching the last page.
  """

  alias Gleanex.Config
  alias Gleanex.Error

  @typedoc """
  A generated operation function taking a request body and options.
  """
  @type operation :: (map, keyword -> {:ok, term} | {:error, Error.t()})

  @doc """
  Stream every page of a cursor-paginated operation.

  Stops when the response has no cursor, when `hasMoreResults` is `false`, or
  when a page repeats the previous cursor, which would otherwise loop forever.

  ## Options

  Passed through to the operation, with `:config` added.
  """
  @spec stream(Config.t(), operation, map, keyword) :: Enumerable.t()
  def stream(%Config{} = config, operation, body \\ %{}, opts \\ [])
      when is_function(operation, 2) and is_map(body) do
    opts = Keyword.put(opts, :config, config)

    # The first page is `{:next, nil}`: no cursor to send, and `next_state/2`
    # rules out a nil cursor before it compares one page's cursor to the last.
    Stream.resource(
      fn -> {:next, nil} end,
      fn
        :done -> {:halt, :done}
        {:next, cursor} -> request(operation, body, opts, cursor)
      end,
      fn _state -> :ok end
    )
  end

  @doc """
  Stream the records inside every page.

  `key` is the field holding the records, for example `:results` for search or
  `:entities` for `/listentities`. Pages without that field contribute nothing.
  """
  @spec stream_items(Config.t(), operation, map, atom, keyword) :: Enumerable.t()
  def stream_items(%Config{} = config, operation, body, key, opts \\ []) do
    config
    |> stream(operation, body, opts)
    |> Stream.flat_map(&items(&1, key))
  end

  defp request(operation, body, opts, cursor) do
    body = if cursor, do: Map.put(body, :cursor, cursor), else: body

    case operation.(body, opts) do
      {:ok, page} -> {[page], next_state(page, cursor)}
      {:error, %Error{} = error} -> raise error
    end
  end

  defp next_state(page, previous_cursor) do
    cursor = field(page, :cursor)

    cond do
      field(page, :hasMoreResults) == false -> :done
      is_nil(cursor) or cursor == "" -> :done
      cursor == previous_cursor -> :done
      true -> {:next, cursor}
    end
  end

  defp field(page, key) when is_struct(page), do: Map.get(page, key)

  defp field(page, key) when is_map(page) do
    Map.get(page, key) || Map.get(page, Atom.to_string(key))
  end

  defp field(_page, _key), do: nil

  defp items(page, key) do
    case field(page, key) do
      nil -> []
      items when is_list(items) -> items
      other -> [other]
    end
  end
end
