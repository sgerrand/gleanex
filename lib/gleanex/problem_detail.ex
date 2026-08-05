defmodule Gleanex.ProblemDetail do
  @moduledoc """
  An RFC 7807 problem detail returned by Glean.

  Glean's Platform API defines `ProblemDetail` as its error body, and the other
  APIs return it for most 4xx and 5xx responses. This is the transport-level
  normalisation of that body: it is parsed with no schema lookup so that error
  handling works even for endpoints whose responses are not in the spec.

  `raw` always holds the decoded body exactly as received, so nothing is lost
  when Glean adds fields.
  """

  @type error_item :: %{optional(atom) => term}

  @type t :: %__MODULE__{
          type: String.t() | nil,
          title: String.t() | nil,
          status: integer | nil,
          detail: String.t() | nil,
          instance: String.t() | nil,
          code: String.t() | nil,
          errors: [error_item],
          raw: map
        }

  defstruct [:type, :title, :status, :detail, :instance, :code, errors: [], raw: %{}]

  @doc """
  Parse a decoded response body into a problem detail.

  Returns `nil` for bodies that carry none of the RFC 7807 fields, so callers
  can fall back to a plain HTTP error.
  """
  @spec parse(term) :: t | nil
  def parse(body) when is_map(body) do
    if problem?(body) do
      %__MODULE__{
        type: Map.get(body, "type"),
        title: Map.get(body, "title"),
        status: Map.get(body, "status"),
        detail: Map.get(body, "detail"),
        instance: Map.get(body, "instance"),
        code: Map.get(body, "code"),
        errors: parse_errors(Map.get(body, "errors")),
        raw: body
      }
    end
  end

  def parse(_body), do: nil

  @doc """
  A one line human readable summary.
  """
  @spec message(t) :: String.t()
  def message(%__MODULE__{} = problem) do
    [problem.title, problem.detail]
    |> Enum.reject(&(is_nil(&1) or &1 == ""))
    |> Enum.uniq()
    |> Enum.join(": ")
    |> case do
      "" -> problem.code || "unknown error"
      text when is_binary(problem.code) -> "#{text} (#{problem.code})"
      text -> text
    end
  end

  defp problem?(body) do
    Enum.any?(["title", "detail", "code", "type"], &Map.has_key?(body, &1))
  end

  defp parse_errors(list) when is_list(list) do
    Enum.map(list, fn
      item when is_map(item) -> Map.new(item, fn {key, value} -> {atomise(key), value} end)
      other -> %{detail: other}
    end)
  end

  defp parse_errors(_), do: []

  # Only ever called on keys that came from Glean's own error payloads, which is
  # a bounded set; still uses the safe variant to keep the atom table finite.
  defp atomise(key) when is_atom(key), do: key

  defp atomise(key) when is_binary(key) do
    String.to_existing_atom(key)
  rescue
    ArgumentError -> key
  end
end
