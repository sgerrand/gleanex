defmodule Gleanex.PaginationTest do
  use ExUnit.Case, async: true

  alias Gleanex.Error
  alias Gleanex.Pagination
  alias Gleanex.Support.Schemas.SearchResponse

  setup do
    %{config: Gleanex.new(domain: "acme", token: "secret")}
  end

  # Serves canned pages and records the bodies it was called with, so the test
  # can assert the cursor was actually sent back.
  defp operation(pages) do
    {:ok, agent} = Agent.start_link(fn -> {pages, []} end)

    fun = fn body, _opts ->
      Agent.get_and_update(agent, fn {[page | rest], seen} ->
        {page, {rest, seen ++ [body]}}
      end)
    end

    {fun, fn -> Agent.get(agent, fn {_pages, seen} -> seen end) end}
  end

  test "stops after a page with no cursor", %{config: config} do
    {fun, _seen} = operation([{:ok, %SearchResponse{results: [1, 2]}}])

    assert [%SearchResponse{results: [1, 2]}] =
             config |> Pagination.stream(fun, %{query: "q"}) |> Enum.to_list()
  end

  test "follows the cursor and sends it back in the next body", %{config: config} do
    {fun, seen} =
      operation([
        {:ok, %SearchResponse{results: [1], cursor: "page-2", hasMoreResults: true}},
        {:ok, %SearchResponse{results: [2], hasMoreResults: false}}
      ])

    pages = config |> Pagination.stream(fun, %{query: "q"}) |> Enum.to_list()

    assert length(pages) == 2
    assert [%{query: "q"}, %{query: "q", cursor: cursor}] = seen.()
    assert cursor == "page-2"
  end

  test "stops when hasMoreResults is false even though a cursor is present", %{config: config} do
    {fun, seen} =
      operation([{:ok, %SearchResponse{results: [1], cursor: "more", hasMoreResults: false}}])

    assert length(config |> Pagination.stream(fun, %{}) |> Enum.to_list()) == 1
    assert length(seen.()) == 1
  end

  test "stops rather than looping when a page repeats the previous cursor", %{config: config} do
    repeated = {:ok, %{"cursor" => "same", "hasMoreResults" => true, "results" => []}}
    {fun, seen} = operation([repeated, repeated, repeated])

    assert length(config |> Pagination.stream(fun, %{}) |> Enum.to_list()) == 2
    assert length(seen.()) == 2
  end

  test "works with plain maps as well as structs", %{config: config} do
    {fun, _seen} =
      operation([
        {:ok, %{"results" => [1], "cursor" => "next"}},
        {:ok, %{"results" => [2]}}
      ])

    assert [%{"results" => [1]}, %{"results" => [2]}] =
             config |> Pagination.stream(fun, %{}) |> Enum.to_list()
  end

  test "is lazy: an unconsumed page is never fetched", %{config: config} do
    {fun, seen} =
      operation([
        {:ok, %SearchResponse{results: [1], cursor: "page-2", hasMoreResults: true}},
        {:ok, %SearchResponse{results: [2], cursor: "page-3", hasMoreResults: true}}
      ])

    assert [_one] = config |> Pagination.stream(fun, %{}) |> Enum.take(1)
    assert length(seen.()) == 1
  end

  test "raises the error a failing page produced", %{config: config} do
    {fun, _seen} = operation([{:error, Error.config("nope")}])

    assert_raise Error, ~r/nope/, fn ->
      config |> Pagination.stream(fun, %{}) |> Enum.to_list()
    end
  end

  test "passes options through to the operation and adds the config", %{config: config} do
    {:ok, agent} = Agent.start_link(fn -> [] end)

    fun = fn _body, opts ->
      Agent.update(agent, fn seen -> seen ++ [opts] end)
      {:ok, %SearchResponse{}}
    end

    config |> Pagination.stream(fun, %{}, timeout: 5) |> Enum.to_list()

    assert [opts] = Agent.get(agent, & &1)
    assert opts[:config] == config
    assert opts[:timeout] == 5
  end

  describe "stream_items/5" do
    test "flattens the records out of each page", %{config: config} do
      {fun, _seen} =
        operation([
          {:ok, %SearchResponse{results: [1, 2], cursor: "page-2", hasMoreResults: true}},
          {:ok, %SearchResponse{results: [3], hasMoreResults: false}}
        ])

      assert [1, 2, 3] = config |> Pagination.stream_items(fun, %{}, :results) |> Enum.to_list()
    end

    test "skips pages missing the field", %{config: config} do
      {fun, _seen} = operation([{:ok, %SearchResponse{results: nil}}])

      assert [] = config |> Pagination.stream_items(fun, %{}, :results) |> Enum.to_list()
    end
  end
end
