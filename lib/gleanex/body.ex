defmodule Gleanex.Body do
  @moduledoc """
  Prepare a request body for JSON encoding.

  Generated operations declare their body as a schema struct, but those structs
  have no `JSON.Encoder` implementation, so handing one straight to the encoder
  raises. This module makes both forms work:

      Gleanex.Client.Search.search(%Gleanex.Client.SearchRequest{query: "holidays"}, config: config)
      Gleanex.Client.Search.search(%{query: "holidays"}, config: config)

  ## Structs drop their unset fields

  A schema struct has a key for every field the API defines, almost all of them
  `nil`. Sending those as JSON nulls would turn "I did not set this" into "set
  this to null", so `nil` values are dropped from structs.

  Plain maps are left alone, nils and all: there a `nil` was written on purpose,
  and a caller that wants to send an explicit null can.

  Structs that already know how to encode themselves, such as `DateTime`, are
  passed through untouched.
  """

  @doc """
  Convert structs to maps, recursively, dropping their unset fields.

  ## Examples

      iex> Gleanex.Body.encode(%Gleanex.Client.SearchRequest{query: "holidays"})
      %{query: "holidays"}

      iex> Gleanex.Body.encode(%{query: "holidays", cursor: nil})
      %{query: "holidays", cursor: nil}

  """
  @spec encode(term) :: term
  def encode(%_struct{} = value) do
    if JSON.Encoder.impl_for(value) do
      value
    else
      value
      |> Map.from_struct()
      |> Enum.reject(fn {_key, field} -> is_nil(field) end)
      |> Map.new(fn {key, field} -> {key, encode(field)} end)
    end
  end

  def encode(value) when is_map(value) do
    Map.new(value, fn {key, field} -> {key, encode(field)} end)
  end

  def encode(value) when is_list(value), do: Enum.map(value, &encode/1)

  def encode(value), do: value
end
