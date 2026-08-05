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

  alias Gleanex.Framing

  # Both forms of line ending, and every mix of them across the blank line that
  # separates two events.
  @line_separators ["\r\n", "\n"]
  @event_separators ["\r\n\r\n", "\r\n\n", "\n\r\n", "\n\n"]

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
    Framing.stream(chunks, @event_separators, &parse/1)
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

  # `data` is accumulated in reverse while parsing, so an event that collected
  # nothing at all is exactly the starting value and needs no separate
  # emptiness check.
  defp blank, do: %Event{data: []}

  defp parse(block) do
    event =
      block
      |> :binary.split(@line_separators, [:global])
      |> Enum.reduce(blank(), &parse_line/2)

    if event == blank(), do: [], else: [%{event | data: join_data(event.data)}]
  end

  # A line beginning with a colon is a comment, and is ignored. So is a line
  # with no colon at all, which the specification treats as a field with an
  # empty value; Glean does not send those.
  defp parse_line(":" <> _comment, event), do: event

  defp parse_line(line, event) do
    case String.split(line, ":", parts: 2) do
      ["data", value] -> %{event | data: [strip(value) | event.data]}
      ["id", value] -> %{event | id: strip(value)}
      ["event", value] -> %{event | event: strip(value)}
      ["retry", value] -> put_retry(event, strip(value))
      _ -> event
    end
  end

  defp put_retry(event, value) do
    case Integer.parse(value) do
      {milliseconds, ""} -> %{event | retry: milliseconds}
      _ -> event
    end
  end

  # A single leading space after the colon is part of the framing, not the value.
  defp strip(" " <> value), do: value
  defp strip(value), do: value

  defp join_data([]), do: nil
  defp join_data(lines), do: lines |> Enum.reverse() |> Enum.join("\n")
end
