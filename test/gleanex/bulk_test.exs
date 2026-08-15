defmodule Gleanex.BulkTest do
  use ExUnit.Case, async: true

  alias Gleanex.Bulk
  alias Gleanex.Error

  setup do
    %{config: Gleanex.new(domain: "acme", token: "secret", scope: :indexing)}
  end

  # Records every body it is called with, and can be told to fail on the nth call.
  defp operation(fail_on \\ nil) do
    {:ok, agent} = Agent.start_link(fn -> [] end)

    fun = fn body, _opts ->
      count = Agent.get_and_update(agent, fn seen -> {length(seen) + 1, seen ++ [body]} end)

      if count == fail_on do
        {:error, Error.config("page #{count} failed")}
      else
        {:ok, %{}}
      end
    end

    {fun, fn -> Agent.get(agent, & &1) end}
  end

  # The callback runs inside upload/6, so a message to self() records what it
  # saw without needing another process.
  defp collect_each do
    parent = self()
    fn response, page -> send(parent, {:each, response, page}) end
  end

  defp collected(seen \\ []) do
    receive do
      {:each, response, page} -> collected([{response, page} | seen])
    after
      0 -> Enum.reverse(seen)
    end
  end

  test "splits records into pages and marks the first and last", %{config: config} do
    {fun, seen} = operation()

    assert {:ok, 3} =
             Bulk.upload(config, fun, %{datasource: "ds"}, :documents, 1..5, page_size: 2)

    assert [first, middle, last] = seen.()

    assert first.documents == [1, 2]
    assert first.isFirstPage == true
    assert first.isLastPage == false

    assert middle.documents == [3, 4]
    assert middle.isFirstPage == false
    assert middle.isLastPage == false

    assert last.documents == [5]
    assert last.isFirstPage == false
    assert last.isLastPage == true
  end

  test "a single page is both first and last", %{config: config} do
    {fun, seen} = operation()

    assert {:ok, 1} = Bulk.upload(config, fun, %{datasource: "ds"}, :documents, [1, 2])

    assert [%{isFirstPage: true, isLastPage: true, documents: [1, 2]}] = seen.()
  end

  test "an empty enumerable still sends one page, which empties the batch", %{config: config} do
    {fun, seen} = operation()

    assert {:ok, 1} = Bulk.upload(config, fun, %{datasource: "ds"}, :documents, [])

    assert [%{isFirstPage: true, isLastPage: true, documents: []}] = seen.()
  end

  test "every page carries the same upload id", %{config: config} do
    {fun, seen} = operation()

    Bulk.upload(config, fun, %{datasource: "ds"}, :documents, 1..5, page_size: 2)

    assert [id] = seen.() |> Enum.map(& &1.uploadId) |> Enum.uniq()
    assert is_binary(id)
  end

  test "an explicit upload id is used, so an interrupted upload can resume", %{config: config} do
    {fun, seen} = operation()

    Bulk.upload(config, fun, %{}, :documents, [1], upload_id: "resume-me")

    assert [%{uploadId: "resume-me"}] = seen.()
  end

  test "shared body fields appear on every page", %{config: config} do
    {fun, seen} = operation()

    Bulk.upload(config, fun, %{datasource: "ds", forceRestartUpload: true}, :documents, 1..3,
      page_size: 1
    )

    for page <- seen.() do
      assert page.datasource == "ds"
      assert page.forceRestartUpload == true
    end
  end

  test "stops at the first failure and leaves the upload uncommitted", %{config: config} do
    {fun, seen} = operation(2)

    assert {:error, %Error{message: message}} =
             Bulk.upload(config, fun, %{}, :documents, 1..6, page_size: 2)

    assert message =~ "page 2 failed"

    # Two attempted, the third never sent, so no page was marked as the last.
    assert length(seen.()) == 2
    refute Enum.any?(seen.(), & &1.isLastPage)
  end

  test "passes the config and extra options to the operation", %{config: config} do
    {:ok, agent} = Agent.start_link(fn -> [] end)

    fun = fn _body, opts ->
      Agent.update(agent, fn seen -> seen ++ [opts] end)
      {:ok, %{}}
    end

    Bulk.upload(config, fun, %{}, :documents, [1], receive_timeout: 60_000)

    assert [opts] = Agent.get(agent, & &1)
    assert opts[:config] == config
    assert opts[:receive_timeout] == 60_000
    refute Keyword.has_key?(opts, :page_size)
    refute Keyword.has_key?(opts, :upload_id)
  end

  test "works with a lazy stream", %{config: config} do
    {fun, seen} = operation()

    records = Stream.map(1..4, & &1)

    assert {:ok, 2} = Bulk.upload(config, fun, %{}, :users, records, page_size: 2)
    assert [%{users: [1, 2]}, %{users: [3, 4]}] = seen.()
  end

  describe ":each" do
    test "runs once per accepted page, in order", %{config: config} do
      {:ok, agent} = Agent.start_link(fn -> 0 end)

      fun = fn _body, _opts ->
        {:ok, %{"page" => Agent.get_and_update(agent, fn n -> {n + 1, n + 1} end)}}
      end

      assert {:ok, 3} =
               Bulk.upload(config, fun, %{}, :documents, 1..5,
                 page_size: 2,
                 each: collect_each()
               )

      assert [{first, first_page}, {second, _}, {third, third_page}] = collected()

      # The response is handed over, which is the whole point: it is otherwise
      # dropped and only the page count survives.
      assert first == %{"page" => 1}
      assert second == %{"page" => 2}
      assert third == %{"page" => 3}

      assert first_page.page == 1
      assert first_page.first? == true
      assert first_page.last? == false
      assert first_page.records == 2

      assert third_page.page == 3
      assert third_page.last? == true
      assert third_page.records == 1
    end

    test "reports the upload id, which is otherwise never seen", %{config: config} do
      {fun, _seen} = operation()

      Bulk.upload(config, fun, %{}, :documents, [1], each: collect_each())

      assert [{_response, page}] = collected()
      assert is_binary(page.upload_id)
    end

    test "does not run for the page that fails", %{config: config} do
      {fun, _seen} = operation(2)

      assert {:error, %Error{}} =
               Bulk.upload(config, fun, %{}, :documents, 1..6,
                 page_size: 2,
                 each: collect_each()
               )

      assert [{_response, page}] = collected()
      assert page.page == 1
    end

    test "is not passed on to the operation", %{config: config} do
      {:ok, agent} = Agent.start_link(fn -> [] end)

      fun = fn _body, opts ->
        Agent.update(agent, fn seen -> seen ++ [opts] end)
        {:ok, %{}}
      end

      Bulk.upload(config, fun, %{}, :documents, [1], each: fn _response, _page -> :ok end)

      assert [opts] = Agent.get(agent, & &1)
      refute Keyword.has_key?(opts, :each)
    end

    test "a callback of the wrong shape fails before anything is sent", %{config: config} do
      {fun, seen} = operation()

      assert_raise Error, ~r/expected :each to be a function of two arguments/, fn ->
        Bulk.upload(config, fun, %{}, :documents, 1..5, each: fn _response -> :ok end)
      end

      assert seen.() == []
    end

    test "what the callback raises comes out of upload/6", %{config: config} do
      {fun, _seen} = operation()

      assert_raise RuntimeError, "from the callback", fn ->
        Bulk.upload(config, fun, %{}, :documents, [1],
          each: fn _response, _page -> raise "from the callback" end
        )
      end
    end
  end
end
