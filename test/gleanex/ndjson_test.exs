defmodule Gleanex.NDJSONTest do
  use ExUnit.Case, async: true

  alias Gleanex.Error
  alias Gleanex.NDJSON

  doctest Gleanex.NDJSON

  defp decode(chunks), do: chunks |> NDJSON.decode() |> Enum.to_list()

  test "decodes one object per line" do
    assert [%{"a" => 1}, %{"a" => 2}] = decode([~s({"a":1}\n{"a":2}\n)])
  end

  test "reassembles an object split across chunks" do
    assert [%{"message" => "hello"}] = decode([~s({"mess), ~s(age":"hel), ~s(lo"}\n)])
  end

  test "emits a trailing line with no newline after it" do
    assert [%{"a" => 1}, %{"a" => 2}] = decode([~s({"a":1}\n{"a":2})])
  end

  test "skips blank lines" do
    assert [%{"a" => 1}, %{"a" => 2}] = decode([~s({"a":1}\n\n\n{"a":2}\n)])
  end

  test "handles carriage returns" do
    assert [%{"a" => 1}, %{"a" => 2}] = decode([~s({"a":1}\r\n{"a":2}\r\n)])
  end

  test "an empty stream yields nothing" do
    assert decode([]) == []
    assert decode([""]) == []
    assert decode(["\n\n"]) == []
  end

  test "is lazy" do
    chunks = Stream.map([~s({"a":1}\n), ~s({"a":2}\n)], & &1)
    assert [%{"a" => 1}] = chunks |> NDJSON.decode() |> Enum.take(1)
  end

  test "raises on a malformed line rather than dropping it" do
    assert_raise Error, ~r/not valid JSON/, fn -> decode([~s({"a":1}\nnot json\n)]) end
  end
end
