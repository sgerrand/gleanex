defmodule Gleanex.NDJSON do
  @moduledoc """
  Decode a newline-delimited JSON stream.

  This is the shape Glean uses for streaming chat. From the description of
  `ChatRequest.stream`:

  > If set, response lines will be streamed one-by-one as they become available.
  > Each will be a ChatResponse, formatted as JSON, and separated by a new line.

  Like `Gleanex.SSE`, this is a plain function over an enumerable of binary
  chunks and reassembles lines split across chunk boundaries.

  ## Examples

      iex> [~s({"a":1}\\n{"a":), ~s(2}\\n)] |> Gleanex.NDJSON.decode() |> Enum.to_list()
      [%{"a" => 1}, %{"a" => 2}]

  """

  alias Gleanex.Error

  @doc """
  Turn a stream of binary chunks into a stream of decoded terms.

  Blank lines are skipped. A malformed line raises `Gleanex.Error` rather than
  being dropped, so a truncated or corrupted stream cannot look like a short but
  complete one.
  """
  @spec decode(Enumerable.t()) :: Enumerable.t()
  def decode(chunks) do
    Stream.transform(
      chunks,
      fn -> "" end,
      &take_lines/2,
      &flush/1,
      fn _buffer -> :ok end
    )
  end

  defp take_lines(chunk, buffer) do
    parts = String.split(buffer <> chunk, ~r/\r?\n/)
    {complete, [remainder]} = Enum.split(parts, -1)

    {complete |> Enum.reject(&blank?/1) |> Enum.map(&decode_line/1), remainder}
  end

  defp flush(buffer) do
    if blank?(buffer), do: {[], buffer}, else: {[decode_line(buffer)], buffer}
  end

  defp blank?(line), do: String.trim(line) == ""

  defp decode_line(line) do
    case JSON.decode(line) do
      {:ok, decoded} ->
        decoded

      {:error, reason} ->
        raise %Error{
          reason: :transport,
          message:
            "Glean sent a line that is not valid JSON (#{inspect(reason)}): #{inspect(line)}"
        }
    end
  end
end
