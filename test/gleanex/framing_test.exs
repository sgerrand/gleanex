defmodule Gleanex.FramingTest do
  use ExUnit.Case, async: true

  alias Gleanex.Framing

  # Gleanex.SSE and Gleanex.NDJSON both reach this module, and between them they
  # do cover it. They cover it incidentally though, through their own parsing,
  # so a change in buffering shows up as a puzzling SSE or NDJSON failure. These
  # tests drive the buffering directly with a parse function that does nothing.

  defp blocks(chunks, separators \\ ["\n"]) do
    chunks |> Framing.stream(separators, &[&1]) |> Enum.to_list()
  end

  describe "stream/3" do
    test "splits a single chunk on the separator" do
      assert blocks(["a\nb\nc\n"]) == ["a", "b", "c"]
    end

    test "holds a block split across two chunks until the rest arrives" do
      assert blocks(["ab", "cd\n"]) == ["abcd"]
    end

    test "holds a block split across many chunks" do
      assert blocks(["a", "b", "c", "d", "\n"]) == ["abcd"]
    end

    test "emits a trailing block that has no separator after it" do
      assert blocks(["a\nb"]) == ["a", "b"]
    end

    test "emits nothing extra when the stream ends on a separator" do
      assert blocks(["a\n"]) == ["a"]
    end

    test "handles a separator arriving on its own in a later chunk" do
      assert blocks(["a", "\n", "b\n"]) == ["a", "b"]
    end

    test "keeps empty blocks between consecutive separators" do
      assert blocks(["a\n\nb\n"]) == ["a", "", "b"]
    end

    test "produces nothing for an empty stream" do
      assert blocks([]) == []
    end

    test "produces nothing for a stream of empty chunks" do
      assert blocks(["", ""]) == []
    end

    test "prefers the longest separator when several match at one point" do
      assert blocks(["a\r\nb\n"], ["\r\n", "\n"]) == ["a", "b"]
    end

    test "matches a two-byte separator split across a chunk boundary" do
      assert blocks(["a\r", "\nb"], ["\r\n", "\n"]) == ["a", "b"]
    end

    test "a parse function returning no elements drops the block" do
      dropped =
        ["keep\nskip\nkeep\n"]
        |> Framing.stream(["\n"], fn block -> if block == "skip", do: [], else: [block] end)
        |> Enum.to_list()

      assert dropped == ["keep", "keep"]
    end

    test "a parse function can expand one block into several elements" do
      expanded =
        ["ab\ncd\n"]
        |> Framing.stream(["\n"], &String.graphemes/1)
        |> Enum.to_list()

      assert expanded == ["a", "b", "c", "d"]
    end

    test "is lazy: only the chunks needed for what is taken are read" do
      read = :counters.new(1, [])

      chunks =
        Stream.map(["a\n", "b\n", "c\n"], fn chunk ->
          :counters.add(read, 1, 1)
          chunk
        end)

      assert chunks |> Framing.stream(["\n"], &[&1]) |> Enum.take(1) == ["a"]
      assert :counters.get(read, 1) == 1
    end

    test "does not call parse for the empty remainder after a final separator" do
      parsed = :counters.new(1, [])

      ["a\n"]
      |> Framing.stream(["\n"], fn block ->
        :counters.add(parsed, 1, 1)
        [block]
      end)
      |> Enum.to_list()

      assert :counters.get(parsed, 1) == 1
    end
  end
end
