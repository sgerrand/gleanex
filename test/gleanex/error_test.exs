defmodule Gleanex.ErrorTest do
  use ExUnit.Case, async: true

  alias Gleanex.Error

  doctest Gleanex.Error

  defp response(status, body, headers \\ []) do
    Enum.reduce(headers, %Req.Response{status: status, body: body}, fn {name, value}, response ->
      Req.Response.put_header(response, name, value)
    end)
  end

  describe "config/1" do
    test "builds a config failure" do
      assert %Error{reason: :config, message: "no token"} = Error.config("no token")
    end
  end

  describe "exception/1" do
    test "can be raised like any other exception" do
      assert_raise Error, fn -> raise Error, reason: :config, message: "boom" end
    end
  end

  describe "from_response/2" do
    test "reports a rate limit with the Retry-After value" do
      error = Error.from_response(response(429, %{}, [{"retry-after", "42"}]), {Mod, :fun})

      assert error.reason == :rate_limited
      assert error.retry_after == 42
      assert Exception.message(error) =~ "rate limited by Glean (HTTP 429, retry after 42s)"
    end

    test "reports a rate limit with no Retry-After header" do
      error = Error.from_response(response(429, %{}), {Mod, :fun})

      assert error.reason == :rate_limited
      assert error.retry_after == nil
      assert Exception.message(error) =~ "rate limited by Glean (HTTP 429)"
      refute Exception.message(error) =~ "retry after"
    end

    test "appends the problem detail to a rate limit message when there is one" do
      error = Error.from_response(response(429, %{"title" => "Slow down"}))

      assert Exception.message(error) =~ "Slow down"
    end

    test "converts a Retry-After given as a date into seconds" do
      date =
        DateTime.utc_now()
        |> DateTime.add(60, :second)
        |> Calendar.strftime("%a, %d %b %Y %H:%M:%S GMT")

      assert %Error{retry_after: seconds} =
               Error.from_response(response(429, %{}, [{"retry-after", date}]))

      assert seconds in 55..60
    end

    test "reports a Retry-After date already in the past as no wait at all" do
      response = response(429, %{}, [{"retry-after", "Wed, 21 Oct 2015 07:28:00 GMT"}])

      assert %Error{retry_after: 0} = Error.from_response(response)
    end

    test "ignores a Retry-After date it cannot read" do
      for value <- ["Wed, 21 Xyz 2026 07:28:00 GMT", "Wed, 32 Oct 2026 07:28:00 GMT", "tomorrow"] do
        assert %Error{retry_after: nil} =
                 Error.from_response(response(429, %{}, [{"retry-after", value}]))
      end
    end

    test "ignores a negative Retry-After" do
      assert %Error{retry_after: nil} =
               Error.from_response(response(429, %{}, [{"retry-after", "-5"}]))
    end

    test "recognises a problem detail body" do
      error = Error.from_response(response(403, %{"title" => "Forbidden", "code" => "NO_SCOPE"}))

      assert error.reason == :problem_detail
      assert error.problem.code == "NO_SCOPE"
      assert Exception.message(error) =~ "Glean returned HTTP 403: Forbidden (NO_SCOPE)"
    end

    test "falls back to a plain HTTP error" do
      error = Error.from_response(response(418, %{"unexpected" => true}))

      assert error.reason == :http
      assert error.body == %{"unexpected" => true}
      assert Exception.message(error) == "Glean returned HTTP 418"
    end

    test "names the operation when it is given" do
      error = Error.from_response(response(500, ""), {Gleanex.Client.Search, :search})

      assert Exception.message(error) ==
               "Gleanex.Client.Search.search: Glean returned HTTP 500"
    end

    test "omits the operation when it is not" do
      assert Error.from_response(response(500, "")) |> Exception.message() ==
               "Glean returned HTTP 500"
    end
  end

  describe "from_exception/2" do
    test "wraps a transport error and names the operation" do
      exception = %Req.TransportError{reason: :econnrefused}
      error = Error.from_exception(exception, {Gleanex.Client.Search, :search})

      assert error.reason == :transport
      assert error.exception == exception
      assert Exception.message(error) =~ "Gleanex.Client.Search.search"
      assert Exception.message(error) =~ "failed to reach Glean"
    end

    test "works without an operation" do
      error = Error.from_exception(%Req.TransportError{reason: :timeout})

      assert String.starts_with?(Exception.message(error), "failed to reach Glean")
    end
  end
end
