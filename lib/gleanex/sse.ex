defmodule Gleanex.SSE do
  @moduledoc """
  Decode a server-sent event stream.

  Glean streams agent runs as `text/event-stream`. This module turns a stream of
  raw binary chunks into a stream of `Gleanex.SSE.Event` structs, reassembling
  events that arrive split across chunk boundaries.

  It is a plain function over an enumerable, so it can be tested with a list of
  binaries and used with anything that produces chunks.

  ## Examples

      iex> ["id: 1\\nevent: message\\ndata: {\\"a\\":1}\\n\\n"]
      ...> |> Gleanex.SSE.decode()
      ...> |> Enum.to_list()
      [%Gleanex.SSE.Event{id: "1", event: "message", data: "{\\"a\\":1}", retry: nil}]

  """

  defmodule Event do
    @moduledoc """
    One server-sent event.

    `data` holds the event payload with multiple `data:` lines joined by
    newlines, as the SSE specification requires. It is left as a string; use
    `Gleanex.SSE.json_data/1` to decode Glean's JSON payloads.
    """

    @type t :: %__MODULE__{
            id: String.t() | nil,
            event: String.t() | nil,
            data: String.t() | nil,
            retry: integer | nil
          }

    defstruct [:id, :event, :data, :retry]
  end

  @doc """
  Turn a stream of binary chunks into a stream of events.

  Events are separated by a blank line. A trailing event with no blank line
  after it, which is what a stream cut short looks like, is still emitted.
  """
  @spec decode(Enumerable.t()) :: Enumerable.t()
  def decode(chunks) do
    Stream.transform(
      chunks,
      fn -> "" end,
      &take_events/2,
      &flush/1,
      fn _buffer -> :ok end
    )
  end

  @doc """
  Decode an event's `data` as JSON.

  Returns `{:ok, term}`, or `{:error, reason}` when the payload is not JSON.
  Glean sends a plain `[DONE]` sentinel on some streams, which is reported as
  `{:error, :not_json}` rather than raising.

  ## Examples

      iex> Gleanex.SSE.json_data(%Gleanex.SSE.Event{data: ~s({"a": 1})})
      {:ok, %{"a" => 1}}

      iex> Gleanex.SSE.json_data(%Gleanex.SSE.Event{data: "[DONE]"})
      {:error, :not_json}

  """
  @spec json_data(Event.t()) :: {:ok, term} | {:error, :not_json | :no_data}
  def json_data(%Event{data: nil}), do: {:error, :no_data}

  def json_data(%Event{data: data}) do
    case JSON.decode(data) do
      {:ok, decoded} -> {:ok, decoded}
      {:error, _reason} -> {:error, :not_json}
    end
  end

  defp take_events(chunk, buffer) do
    parts = String.split(buffer <> chunk, ~r/\r?\n\r?\n/)
    {complete, [remainder]} = Enum.split(parts, -1)

    {complete |> Enum.map(&parse/1) |> Enum.reject(&is_nil/1), remainder}
  end

  defp flush(buffer) do
    case parse(buffer) do
      nil -> {[], buffer}
      event -> {[event], buffer}
    end
  end

  defp parse(block) do
    fields =
      block
      |> String.split(~r/\r?\n/)
      |> Enum.reduce(%{data: []}, &parse_line/2)

    if empty?(fields) do
      nil
    else
      %Event{
        id: fields[:id],
        event: fields[:event],
        data: join_data(fields.data),
        retry: fields[:retry]
      }
    end
  end

  # A line beginning with a colon is a comment, and is ignored. So is a line
  # with no colon at all, which the specification treats as a field with an
  # empty value; Glean does not send those.
  defp parse_line(":" <> _comment, fields), do: fields

  defp parse_line(line, fields) do
    case String.split(line, ":", parts: 2) do
      ["data", value] -> Map.update!(fields, :data, &[strip(value) | &1])
      ["id", value] -> Map.put(fields, :id, strip(value))
      ["event", value] -> Map.put(fields, :event, strip(value))
      ["retry", value] -> put_retry(fields, strip(value))
      _ -> fields
    end
  end

  defp put_retry(fields, value) do
    case Integer.parse(value) do
      {milliseconds, ""} -> Map.put(fields, :retry, milliseconds)
      _ -> fields
    end
  end

  # A single leading space after the colon is part of the framing, not the value.
  defp strip(" " <> value), do: value
  defp strip(value), do: value

  defp join_data([]), do: nil
  defp join_data(lines), do: lines |> Enum.reverse() |> Enum.join("\n")

  defp empty?(fields) do
    fields.data == [] and is_nil(fields[:id]) and is_nil(fields[:event]) and
      is_nil(fields[:retry])
  end
end
