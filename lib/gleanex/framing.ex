defmodule Gleanex.Framing do
  @moduledoc """
  Reassemble a stream of binary chunks into whole blocks.

  `Gleanex.NDJSON` and `Gleanex.SSE` read the same shape of response and differ
  only in what separates one block from the next and how a block is parsed. The
  part worth writing once is the buffering: a block split across two chunks has
  to be held until the rest arrives, and a stream that ends without a trailing
  separator still has to emit what it has.

  Internal plumbing for those two modules, not part of the published surface.
  """

  @doc """
  Split `chunks` on any of `separators` and run `parse` over each whole block.

  `parse` returns a list, so a block can decode to one element or to none.
  Separators match leftmost-longest, so `["\\r\\n", "\\n"]` prefers CRLF.

  A stream that ends on a separator leaves nothing behind, and `parse` is not
  called for that empty remainder.
  """
  @spec stream(Enumerable.t(), [binary], (binary -> [term])) :: Enumerable.t()
  def stream(chunks, separators, parse) do
    Stream.transform(
      chunks,
      fn -> "" end,
      fn chunk, buffer ->
        {complete, [remainder]} =
          (buffer <> chunk) |> :binary.split(separators, [:global]) |> Enum.split(-1)

        {Enum.flat_map(complete, parse), remainder}
      end,
      fn
        "" -> {[], ""}
        buffer -> {parse.(buffer), buffer}
      end,
      fn _buffer -> :ok end
    )
  end
end
