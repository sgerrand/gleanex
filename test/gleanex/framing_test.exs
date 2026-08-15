defmodule Gleanex.FramingTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Gleanex.Framing
  alias Gleanex.NDJSON
  alias Gleanex.SSE

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

  # The examples above pin the boundaries someone thought of. The whole point of
  # this module is that no boundary matters at all, which is a claim about every
  # split rather than a handful, and is what these check.
  describe "chunking is invisible" do
    property "the result depends on the bytes, not on where the chunks fall" do
      check all data <- payload(),
                chunks <- chunked(data) do
        assert blocks(chunks) == blocks([data])
      end
    end

    property "the same holds for a two-byte separator, split or not" do
      check all data <- payload(),
                chunks <- chunked(data) do
        assert blocks(chunks, ["\r\n", "\n"]) == blocks([data], ["\r\n", "\n"])
      end
    end

    property "every block comes back, however the bytes were delivered" do
      check all parts <- list_of(word(), max_length: 8),
                data = Enum.map_join(parts, &(&1 <> "\n")),
                chunks <- chunked(data) do
        assert blocks(chunks) == parts
      end
    end
  end

  describe "the decoders built on it" do
    property "NDJSON decodes the same values whatever the chunking" do
      check all values <- list_of(json_value(), max_length: 6),
                data = Enum.map_join(values, &(JSON.encode!(&1) <> "\n")),
                chunks <- chunked(data) do
        assert chunks |> NDJSON.decode() |> Enum.to_list() == values
      end
    end

    property "SSE decodes the same events whatever the chunking" do
      check all events <- list_of(sse_event(), max_length: 6),
                data = Enum.map_join(events, &serialise_event/1),
                chunks <- chunked(data) do
        decoded = chunks |> SSE.decode() |> Enum.to_list()

        assert Enum.map(decoded, & &1.data) == Enum.map(events, & &1.data)
        assert Enum.map(decoded, & &1.id) == Enum.map(events, & &1.id)
        assert Enum.map(decoded, & &1.event) == Enum.map(events, & &1.event)
      end
    end
  end

  # Every generator here is bounded rather than left to grow with StreamData's
  # size parameter. `Framing` holds a buffer and concatenates onto it, so a run
  # that generates a large payload and cuts it into hundreds of chunks is
  # quadratic, and raising :max_runs would make the suite crawl rather than look
  # harder. Chunk boundaries are what these tests vary; payload size is not.
  defp payload, do: binary(max_length: 48)

  defp word, do: string(:alphanumeric, max_length: 8)

  # Every way of cutting `data` into consecutive pieces, including no cuts at
  # all and cuts that produce empty chunks.
  defp chunked(data) when byte_size(data) < 2, do: constant([data])

  defp chunked(data) do
    gen all cuts <- list_of(integer(0..byte_size(data)), max_length: 12) do
      cuts
      |> Enum.sort()
      |> Enum.uniq()
      |> Enum.reduce({[], 0}, fn cut, {pieces, taken} ->
        {[binary_part(data, taken, cut - taken) | pieces], cut}
      end)
      |> then(fn {pieces, taken} ->
        Enum.reverse([binary_part(data, taken, byte_size(data) - taken) | pieces])
      end)
    end
  end

  # Values that survive a JSON round trip unchanged, so a mismatch is the
  # framing rather than the encoding. Floats are left out deliberately: their
  # text form is JSON's business, not this module's.
  defp json_value do
    one_of([
      word(),
      integer(),
      boolean(),
      constant(nil),
      list_of(integer(), max_length: 3),
      map_of(word(), integer(), max_length: 3)
    ])
  end

  # `data` is never nil, because an event that collected no fields at all is
  # dropped rather than emitted. Alphanumeric values also keep clear of the two
  # things SSE framing would eat: a leading space after the colon is stripped,
  # and a newline would start a new field.
  defp sse_event do
    gen all id <- one_of([constant(nil), field_value()]),
            event <- one_of([constant(nil), field_value()]),
            data <- field_value() do
      %SSE.Event{id: id, event: event, data: data}
    end
  end

  defp field_value, do: string(:alphanumeric, min_length: 1, max_length: 8)

  defp serialise_event(%SSE.Event{} = event) do
    [{"id", event.id}, {"event", event.event}, {"data", event.data}]
    |> Enum.reject(fn {_name, value} -> is_nil(value) end)
    |> Enum.map_join(fn {name, value} -> "#{name}: #{value}\n" end)
    |> Kernel.<>("\n")
  end
end
