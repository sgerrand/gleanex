defmodule Gleanex.SSETest do
  use ExUnit.Case, async: true

  alias Gleanex.SSE
  alias Gleanex.SSE.Event

  doctest Gleanex.SSE

  defp decode(chunks), do: chunks |> SSE.decode() |> Enum.to_list()

  test "decodes a single event" do
    assert [%Event{id: "1", event: "message", data: ~s({"a":1})}] =
             decode(["id: 1\nevent: message\ndata: {\"a\":1}\n\n"])
  end

  test "decodes several events in one chunk" do
    assert [%Event{data: "one"}, %Event{data: "two"}] =
             decode(["data: one\n\ndata: two\n\n"])
  end

  test "reassembles an event split across chunks" do
    assert [%Event{event: "message", data: "hello world"}] =
             decode(["event: mess", "age\nda", "ta: hello wo", "rld\n\n"])
  end

  test "emits a trailing event that has no blank line after it" do
    assert [%Event{data: "first"}, %Event{data: "cut short"}] =
             decode(["data: first\n\ndata: cut short"])
  end

  test "joins multiple data lines with newlines, as the SSE spec requires" do
    assert [%Event{data: "line one\nline two"}] = decode(["data: line one\ndata: line two\n\n"])
  end

  test "strips only one leading space after the colon" do
    assert [%Event{data: " indented"}] = decode(["data:  indented\n\n"])
  end

  test "accepts a field with no space after the colon" do
    assert [%Event{data: "tight"}] = decode(["data:tight\n\n"])
  end

  test "ignores comment lines" do
    assert [%Event{data: "kept"}] = decode([": keep-alive\ndata: kept\n\n"])
  end

  test "skips blocks that hold nothing but comments" do
    assert [%Event{data: "real"}] = decode([": ping\n\ndata: real\n\n"])
  end

  test "handles carriage returns" do
    assert [%Event{id: "1", data: "windows"}] = decode(["id: 1\r\ndata: windows\r\n\r\n"])
  end

  test "parses retry as milliseconds and ignores it when not a number" do
    assert [%Event{retry: 3000}] = decode(["retry: 3000\ndata: x\n\n"])
    assert [%Event{retry: nil}] = decode(["retry: soon\ndata: x\n\n"])
  end

  test "an empty stream yields nothing" do
    assert decode([]) == []
    assert decode([""]) == []
  end

  describe "json_data/1" do
    test "decodes a JSON payload" do
      assert {:ok, %{"a" => 1}} = SSE.json_data(%Event{data: ~s({"a": 1})})
    end

    test "reports a non-JSON payload rather than raising" do
      assert {:error, :not_json} = SSE.json_data(%Event{data: "[DONE]"})
    end

    test "reports an event with no data" do
      assert {:error, :no_data} = SSE.json_data(%Event{data: nil})
    end
  end
end
