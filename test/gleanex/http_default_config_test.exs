defmodule Gleanex.HTTPDefaultConfigTest do
  @moduledoc """
  Calls made without an explicit `:config`.

  Separate from the rest of the transport tests because these depend on the
  application environment, which is global and cannot be manipulated from an
  async test.
  """

  # Not async: mutates the application environment.
  use ExUnit.Case, async: false

  alias Gleanex.Client.SupportSearch
  alias Gleanex.Error

  setup context do
    Req.Test.set_req_test_from_context(context)
    :ok
  end

  test "falls back to the application environment when no config is passed" do
    with_app_env(
      %{
        domain: "from-app-env",
        token: "app-env-token",
        req_options: [plug: {Req.Test, GleanexDefaultStub}]
      },
      fn ->
        Req.Test.stub(GleanexDefaultStub, fn conn ->
          assert conn.host == "from-app-env-be.glean.com"
          assert Plug.Conn.get_req_header(conn, "authorization") == ["Bearer app-env-token"]

          Req.Test.json(conn, %{})
        end)

        assert {:ok, _} = SupportSearch.search(%{query: "holidays"})
      end
    )
  end

  test "returns a config error rather than raising when nothing is configured" do
    with_app_env(%{domain: nil, token: nil, req_options: nil}, fn ->
      with_env(
        %{"GLEAN_API_TOKEN" => nil, "GLEAN_INSTANCE" => nil, "GLEAN_BASE_URL" => nil},
        fn ->
          assert {:error, %Error{reason: :config, message: message}} =
                   SupportSearch.search(%{query: "holidays"})

          assert message =~ "missing Glean API token"
        end
      )
    end)
  end

  defp with_app_env(settings, fun) do
    keys = Map.keys(settings)
    previous = Map.new(keys, &{&1, Application.get_env(:gleanex, &1)})

    Enum.each(settings, fn
      {key, nil} -> Application.delete_env(:gleanex, key)
      {key, value} -> Application.put_env(:gleanex, key, value)
    end)

    try do
      fun.()
    after
      Enum.each(previous, fn
        {key, nil} -> Application.delete_env(:gleanex, key)
        {key, value} -> Application.put_env(:gleanex, key, value)
      end)
    end
  end

  defp with_env(vars, fun) do
    previous = Map.new(vars, fn {name, _} -> {name, System.get_env(name)} end)

    Enum.each(vars, fn
      {name, nil} -> System.delete_env(name)
      {name, value} -> System.put_env(name, value)
    end)

    try do
      fun.()
    after
      Enum.each(previous, fn
        {name, nil} -> System.delete_env(name)
        {name, value} -> System.put_env(name, value)
      end)
    end
  end
end
