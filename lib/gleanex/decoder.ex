defmodule Gleanex.Decoder do
  @moduledoc """
  Turn decoded JSON into the structs described by the generated schemas.

  Generated schema modules expose `__fields__/1`, a keyword list mapping each
  field to its type. This module walks that description to build structs, lists
  of structs and nested values.

  Anything it cannot place is passed through untouched, so an outdated spec
  degrades to plain maps rather than losing data or crashing.
  """

  @doc """
  Decode `value` according to a generated type description.

  ## Type forms

    * `{Module, :t}` - build that struct
    * `[type]` - a list of that type
    * `{:union, types}` - best effort, see below
    * anything else - returned unchanged

  Unions are ambiguous by nature. For a map, the candidate struct sharing the
  most field names with the payload wins; ties go to the leftmost candidate. For
  everything else the value passes through.
  """
  @spec decode(term, term) :: term
  def decode(nil, _type), do: nil

  def decode(value, [inner]) when is_list(value) do
    Enum.map(value, &decode(&1, inner))
  end

  def decode(value, {:union, types}) do
    case best_match(value, types) do
      nil -> value
      type -> decode(value, type)
    end
  end

  def decode(value, {module, type}) when is_atom(module) and is_atom(type) and is_map(value) do
    if schema?(module) do
      build(module, type, value)
    else
      value
    end
  end

  def decode(value, _type), do: value

  defp build(module, type, payload) do
    module.__fields__(type)
    |> Enum.reduce(%{}, fn {field, field_type}, acc ->
      case fetch(payload, field) do
        {:ok, raw} -> Map.put(acc, field, decode(raw, field_type))
        :error -> acc
      end
    end)
    |> then(&struct(module, &1))
  end

  defp fetch(payload, field) do
    case Map.fetch(payload, Atom.to_string(field)) do
      {:ok, value} -> {:ok, value}
      :error -> Map.fetch(payload, field)
    end
  end

  defp best_match(value, types) when is_map(value) do
    types
    |> Enum.filter(&struct_type?/1)
    |> Enum.max_by(&overlap(&1, value), fn -> nil end)
    |> case do
      nil -> nil
      type -> if overlap(type, value) > 0, do: type, else: nil
    end
  end

  defp best_match(value, types) when is_list(value) do
    Enum.find(types, &match?([_], &1))
  end

  defp best_match(_value, _types), do: nil

  defp struct_type?({module, type}) when is_atom(module) and is_atom(type), do: schema?(module)
  defp struct_type?(_), do: false

  defp overlap({module, type}, payload) do
    known = module.__fields__(type) |> Keyword.keys() |> MapSet.new()

    payload
    |> Map.keys()
    |> Enum.count(fn key -> MapSet.member?(known, to_atom(key)) end)
  end

  defp to_atom(key) when is_atom(key), do: key

  defp to_atom(key) when is_binary(key) do
    String.to_existing_atom(key)
  rescue
    ArgumentError -> nil
  end

  defp schema?(module) do
    Code.ensure_loaded?(module) and function_exported?(module, :__fields__, 1)
  end
end
