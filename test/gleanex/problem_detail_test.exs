defmodule Gleanex.ProblemDetailTest do
  use ExUnit.Case, async: true

  alias Gleanex.ProblemDetail

  doctest Gleanex.ProblemDetail

  describe "parse/1" do
    test "reads the RFC 7807 fields" do
      body = %{
        "type" => "https://glean.com/errors/forbidden",
        "title" => "Forbidden",
        "status" => 403,
        "detail" => "The token lacks the required scope",
        "instance" => "/rest/api/v1/search",
        "code" => "INSUFFICIENT_SCOPE"
      }

      assert %ProblemDetail{
               type: "https://glean.com/errors/forbidden",
               title: "Forbidden",
               status: 403,
               detail: "The token lacks the required scope",
               instance: "/rest/api/v1/search",
               code: "INSUFFICIENT_SCOPE"
             } = ProblemDetail.parse(body)
    end

    test "keeps the body verbatim, so nothing is lost when Glean adds a field" do
      body = %{"title" => "Forbidden", "somethingNew" => %{"nested" => true}}
      assert %ProblemDetail{raw: ^body} = ProblemDetail.parse(body)
    end

    test "recognises a body carrying any one of the identifying fields" do
      for key <- ["title", "detail", "code", "type"] do
        assert %ProblemDetail{} = ProblemDetail.parse(%{key => "something"})
      end
    end

    test "returns nil for a body with none of them" do
      assert ProblemDetail.parse(%{"results" => []}) == nil
    end

    test "returns nil for bodies that are not maps" do
      assert ProblemDetail.parse("plain text") == nil
      assert ProblemDetail.parse(nil) == nil
      assert ProblemDetail.parse([1, 2]) == nil
    end

    test "parses the errors list into maps with atom keys" do
      body = %{"title" => "Bad Request", "errors" => [%{"detail" => "query is required"}]}

      assert %ProblemDetail{errors: [%{detail: "query is required"}]} = ProblemDetail.parse(body)
    end

    test "keeps an error key as a string when it is not already a known atom" do
      body = %{"title" => "Bad Request", "errors" => [%{"aKeyNobodyHasEverUsedBefore" => 1}]}

      assert %ProblemDetail{errors: [error]} = ProblemDetail.parse(body)
      assert error == %{"aKeyNobodyHasEverUsedBefore" => 1}
    end

    test "accepts error items that already have atom keys" do
      body = %{"title" => "Bad Request", "errors" => [%{detail: "already an atom"}]}

      assert %ProblemDetail{errors: [%{detail: "already an atom"}]} = ProblemDetail.parse(body)
    end

    test "wraps an error item that is not a map" do
      body = %{"title" => "Bad Request", "errors" => ["just a string"]}

      assert %ProblemDetail{errors: [%{detail: "just a string"}]} = ProblemDetail.parse(body)
    end

    test "treats a non-list errors field as no errors" do
      assert %ProblemDetail{errors: []} =
               ProblemDetail.parse(%{"title" => "x", "errors" => "oops"})

      assert %ProblemDetail{errors: []} = ProblemDetail.parse(%{"title" => "x"})
    end
  end

  describe "message/1" do
    test "joins the title and detail" do
      problem = ProblemDetail.parse(%{"title" => "Forbidden", "detail" => "No scope"})
      assert ProblemDetail.message(problem) == "Forbidden: No scope"
    end

    test "appends the code when there is one" do
      problem = ProblemDetail.parse(%{"title" => "Forbidden", "code" => "NO_SCOPE"})
      assert ProblemDetail.message(problem) == "Forbidden (NO_SCOPE)"
    end

    test "does not repeat a detail identical to the title" do
      problem = ProblemDetail.parse(%{"title" => "Forbidden", "detail" => "Forbidden"})
      assert ProblemDetail.message(problem) == "Forbidden"
    end

    test "uses just the detail when there is no title" do
      problem = ProblemDetail.parse(%{"detail" => "Something went wrong"})
      assert ProblemDetail.message(problem) == "Something went wrong"
    end

    test "falls back to the code when title and detail are both absent" do
      problem = ProblemDetail.parse(%{"code" => "RATE_LIMITED"})
      assert ProblemDetail.message(problem) == "RATE_LIMITED"
    end

    test "falls back to the code when title and detail are both empty strings" do
      problem = ProblemDetail.parse(%{"title" => "", "detail" => "", "code" => "EMPTY"})
      assert ProblemDetail.message(problem) == "EMPTY"
    end

    test "says so when there is nothing to report at all" do
      problem = ProblemDetail.parse(%{"type" => "about:blank", "title" => "", "detail" => ""})
      assert ProblemDetail.message(problem) == "unknown error"
    end
  end
end
