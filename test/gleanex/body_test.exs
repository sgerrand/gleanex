defmodule Gleanex.BodyTest do
  use ExUnit.Case, async: true

  alias Gleanex.Body
  alias Gleanex.Client.ChatMessage
  alias Gleanex.Client.ChatMessageFragment
  alias Gleanex.Client.ChatRequest
  alias Gleanex.Client.SearchRequest

  doctest Gleanex.Body

  test "a schema struct becomes a map with its unset fields dropped" do
    assert Body.encode(%SearchRequest{query: "holidays", pageSize: 10}) == %{
             query: "holidays",
             pageSize: 10
           }
  end

  test "the result is JSON encodable, which the struct itself is not" do
    request = %SearchRequest{query: "holidays"}

    assert_raise Protocol.UndefinedError, fn -> JSON.encode!(request) end
    assert JSON.encode!(Body.encode(request)) == ~s({"query":"holidays"})
  end

  test "nested structs and lists of structs are converted too" do
    request = %ChatRequest{
      messages: [
        %ChatMessage{author: "USER", fragments: [%ChatMessageFragment{text: "hi"}]}
      ]
    }

    assert Body.encode(request) == %{
             messages: [%{author: "USER", fragments: [%{text: "hi"}]}]
           }
  end

  test "plain maps keep their nils, because those were written on purpose" do
    assert Body.encode(%{query: "holidays", cursor: nil}) == %{query: "holidays", cursor: nil}
  end

  test "structs nested inside a plain map are still converted" do
    assert Body.encode(%{request: %SearchRequest{query: "q"}}) == %{request: %{query: "q"}}
  end

  test "structs that can encode themselves are left alone" do
    stamp = ~U[2026-07-28 12:00:00Z]
    assert Body.encode(%{timestamp: stamp}) == %{timestamp: stamp}
    assert JSON.encode!(Body.encode(%{timestamp: stamp})) =~ "2026-07-28"
  end

  test "scalars and lists pass through" do
    assert Body.encode("text") == "text"
    assert Body.encode(42) == 42
    assert Body.encode(nil) == nil
    assert Body.encode([1, "two"]) == [1, "two"]
  end

  test "an empty struct encodes to an empty object rather than a wall of nulls" do
    assert Body.encode(%SearchRequest{}) == %{}
  end
end
