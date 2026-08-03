defmodule Gleanex.DecoderTest do
  use ExUnit.Case, async: true

  alias Gleanex.Decoder
  alias Gleanex.Support.Schemas.Person
  alias Gleanex.Support.Schemas.Result
  alias Gleanex.Support.Schemas.SearchResponse

  doctest Gleanex.Decoder

  test "builds a struct from string keys" do
    assert %Person{name: "Ada", email: "ada@example.com"} =
             Decoder.decode(%{"name" => "Ada", "email" => "ada@example.com"}, {Person, :t})
  end

  test "accepts atom keys too" do
    assert %Person{name: "Ada"} = Decoder.decode(%{name: "Ada"}, {Person, :t})
  end

  test "leaves absent fields at their struct default" do
    assert %SearchResponse{results: [], trackingToken: nil} =
             Decoder.decode(%{"hasMoreResults" => false}, {SearchResponse, :t})
  end

  test "ignores fields the schema does not know about" do
    assert %Person{name: "Ada"} =
             Decoder.decode(%{"name" => "Ada", "nickname" => "A"}, {Person, :t})
  end

  test "decodes nested structs and lists of structs" do
    payload = %{
      "results" => [
        %{"title" => "One", "author" => %{"name" => "Ada"}},
        %{"title" => "Two", "author" => %{"name" => "Grace"}}
      ]
    }

    assert %SearchResponse{results: [first, second]} =
             Decoder.decode(payload, {SearchResponse, :t})

    assert %Result{title: "One", author: %Person{name: "Ada"}} = first
    assert %Result{title: "Two", author: %Person{name: "Grace"}} = second
  end

  test "passes nil through" do
    assert Decoder.decode(nil, {Person, :t}) == nil
  end

  test "passes scalars through untouched" do
    assert Decoder.decode("text", {:string, :generic}) == "text"
    assert Decoder.decode(7, :integer) == 7
    assert Decoder.decode(%{"a" => 1}, :map) == %{"a" => 1}
  end

  test "passes maps through when the named module is not a generated schema" do
    assert Decoder.decode(%{"a" => 1}, {NotALoadedSchema, :t}) == %{"a" => 1}
  end

  describe "unions" do
    test "picks the candidate sharing the most fields with the payload" do
      payload = %{"title" => "One", "url" => "https://example.com"}

      assert %Result{title: "One"} =
               Decoder.decode(payload, {:union, [{Person, :t}, {Result, :t}]})
    end

    test "picks the other way round when the payload says so" do
      payload = %{"name" => "Ada", "email" => "ada@example.com"}

      assert %Person{name: "Ada"} =
               Decoder.decode(payload, {:union, [{Person, :t}, {Result, :t}]})
    end

    test "passes the payload through when nothing overlaps" do
      payload = %{"totally" => "unrelated"}
      assert Decoder.decode(payload, {:union, [{Person, :t}, {Result, :t}]}) == payload
    end

    test "handles a nullable union of one struct" do
      assert %Person{name: "Ada"} =
               Decoder.decode(%{"name" => "Ada"}, {:union, [{Person, :t}, :null]})

      assert Decoder.decode(nil, {:union, [{Person, :t}, :null]}) == nil
    end

    test "passes a map through when the union holds no struct to match it against" do
      assert Decoder.decode(%{"a" => 1}, {:union, [:string, :integer]}) == %{"a" => 1}
    end

    test "matches on atom keys as well as string keys" do
      payload = %{name: "Ada", email: "ada@example.com"}

      assert %Person{name: "Ada"} =
               Decoder.decode(payload, {:union, [{Person, :t}, {Result, :t}]})
    end

    test "passes a scalar through, since there is nothing to match on" do
      assert Decoder.decode("text", {:union, [{Person, :t}, :string]}) == "text"
      assert Decoder.decode(7, {:union, [{Person, :t}, :integer]}) == 7
    end

    test "passes a list through when the union has no list branch" do
      assert Decoder.decode([1, 2], {:union, [{Person, :t}, :string]}) == [1, 2]
    end

    test "finds the list branch for a list payload" do
      payload = [%{"name" => "Ada"}]
      assert [%Person{name: "Ada"}] = Decoder.decode(payload, {:union, [:null, [{Person, :t}]]})
    end
  end
end
