defmodule Gleanex.ConfigTest do
  # Not async: several tests mutate the system environment, which is global.
  use ExUnit.Case, async: false

  alias Gleanex.Config
  alias Gleanex.Error

  doctest Gleanex.Config

  describe "new/1" do
    test "builds a config from explicit options" do
      config = Gleanex.new(domain: "acme", token: "secret")

      assert config.domain == "acme"
      assert config.token == "secret"
      assert config.scope == :client
      assert config.receive_timeout == 30_000
    end

    test "accepts :instance as an alias for :domain, matching the Go SDK" do
      assert Gleanex.new(instance: "acme", token: "secret").domain == "acme"
    end

    test "prefers :domain when both are given" do
      assert Gleanex.new(domain: "acme", instance: "other", token: "secret").domain == "acme"
    end

    test "trims a trailing slash from :base_url" do
      config = Gleanex.new(base_url: "https://be4f5226-be.glean.com/", token: "secret")
      assert config.base_url == "https://be4f5226-be.glean.com"
    end

    test "falls back to environment variables" do
      with_env(%{"GLEAN_INSTANCE" => "from-env", "GLEAN_API_TOKEN" => "env-token"}, fn ->
        config = Config.new([])
        assert config.domain == "from-env"
        assert config.token == "env-token"
      end)
    end

    test "options win over environment variables" do
      with_env(%{"GLEAN_INSTANCE" => "from-env", "GLEAN_API_TOKEN" => "env-token"}, fn ->
        assert Config.new(domain: "explicit").domain == "explicit"
      end)
    end

    test "treats an empty environment variable as unset" do
      with_env(%{"GLEAN_INSTANCE" => "", "GLEAN_API_TOKEN" => "env-token"}, fn ->
        assert_raise Error, ~r/missing Glean domain/, fn -> Config.new([]) end
      end)
    end

    test "raises when the token is missing" do
      with_env(%{"GLEAN_API_TOKEN" => nil}, fn ->
        assert_raise Error, ~r/missing Glean API token/, fn -> Config.new(domain: "acme") end
      end)
    end

    test "raises when neither domain nor base_url can be resolved" do
      with_env(%{"GLEAN_INSTANCE" => nil}, fn ->
        assert_raise Error, ~r/missing Glean domain/, fn -> Config.new(token: "secret") end
      end)
    end

    test "raises on an unknown scope" do
      assert_raise Error, ~r/invalid :scope/, fn ->
        Gleanex.new(domain: "acme", token: "secret", scope: :admin)
      end
    end

    test "raises on a :base_url that is not a bare host root" do
      for base_url <- [
            "https://acme-be.glean.com/glean",
            "https://acme-be.glean.com/rest/api/v1",
            "https://acme-be.glean.com?a=1",
            "https://acme-be.glean.com#frag",
            "acme-be.glean.com",
            "ftp://acme-be.glean.com",
            "not a url"
          ] do
        assert_raise Error, ~r/invalid :base_url/, fn ->
          Gleanex.new(base_url: base_url, token: "secret")
        end
      end
    end

    test "accepts a bare host root, with or without a port or trailing slash" do
      for base_url <- [
            "https://acme-be.glean.com",
            "https://acme-be.glean.com/",
            "http://localhost:4000"
          ] do
        assert %Config{} = Gleanex.new(base_url: base_url, token: "secret")
      end
    end

    test "a proxy prefix goes in req_options, which replaces the whole base URL" do
      config =
        Gleanex.new(
          domain: "acme",
          token: "secret",
          req_options: [base_url: "https://proxy.internal/glean/rest/api/v1"]
        )

      request = Gleanex.HTTP.build_request(config, :client, %{url: "/search"})

      assert request.options[:base_url] == "https://proxy.internal/glean/rest/api/v1"
    end
  end

  describe "settings from the application environment" do
    test "reads a {:system, var} tuple at call time, not at compile time" do
      with_env(%{"GLEAN_TOKEN_FROM_TUPLE" => "resolved-later"}, fn ->
        with_app_env(%{token: {:system, "GLEAN_TOKEN_FROM_TUPLE"}, domain: "acme"}, fn ->
          assert Config.new([]).token == "resolved-later"
        end)
      end)
    end

    test "treats a {:system, var} tuple naming an unset variable as unset" do
      with_env(%{"GLEAN_API_TOKEN" => nil, "GLEAN_NOT_SET_ANYWHERE" => nil}, fn ->
        with_app_env(%{token: {:system, "GLEAN_NOT_SET_ANYWHERE"}, domain: "acme"}, fn ->
          assert_raise Error, ~r/missing Glean API token/, fn -> Config.new([]) end
        end)
      end)
    end

    test "picks up the retry policy, timeout and Req options" do
      retry = Gleanex.Retry.disabled()

      with_app_env(
        %{domain: "acme", token: "t", retry: retry, receive_timeout: 1234, req_options: [foo: 1]},
        fn ->
          config = Config.new([])

          assert config.retry == retry
          assert config.receive_timeout == 1234
          assert config.req_options == [foo: 1]
        end
      )
    end

    test "default/0 builds the same config as new/0" do
      with_app_env(%{domain: "acme", token: "t"}, fn ->
        assert Config.default() == Config.new()
      end)
    end
  end

  describe "prefix/1 and apis/0" do
    test "lists the four APIs" do
      assert Enum.sort(Config.apis()) == [:admin, :client, :indexing, :platform]
    end

    test "gives each API its path prefix" do
      assert Config.prefix(:client) == "/rest/api/v1"
      assert Config.prefix(:indexing) == "/api/index/v1"
      assert Config.prefix(:platform) == "/api"
      assert Config.prefix(:admin) == "/rest/api/v1"
    end

    test "every API has a prefix" do
      for api <- Config.apis(), do: assert(is_binary(Config.prefix(api)))
    end
  end

  describe "base_url/2" do
    setup do
      %{config: Gleanex.new(domain: "acme", token: "secret")}
    end

    test "appends the per-API path prefix", %{config: config} do
      assert Config.base_url(config, :client) == "https://acme-be.glean.com/rest/api/v1"
      assert Config.base_url(config, :indexing) == "https://acme-be.glean.com/api/index/v1"
      assert Config.base_url(config, :platform) == "https://acme-be.glean.com/api"
      assert Config.base_url(config, :admin) == "https://acme-be.glean.com/rest/api/v1"
    end

    test "a base_url override replaces the host root but keeps the prefix" do
      config = Gleanex.new(base_url: "http://localhost:4000", token: "secret")
      assert Config.base_url(config, :client) == "http://localhost:4000/rest/api/v1"
    end

    test "base_url wins over domain" do
      config = Gleanex.new(domain: "acme", base_url: "http://localhost:4000", token: "secret")
      assert Config.base_url(config, :indexing) == "http://localhost:4000/api/index/v1"
    end
  end

  describe "check_scope/2" do
    test "a client token may not call the Indexing API" do
      config = Gleanex.new(domain: "acme", token: "secret")

      assert {:error, %Error{reason: :config, message: message}} =
               Config.check_scope(config, :indexing)

      assert message =~ "holds a client token"
      assert message =~ "not interchangeable"
    end

    test "an indexing token may not call the other APIs" do
      config = Gleanex.new(domain: "acme", token: "secret", scope: :indexing)

      for api <- [:client, :platform, :admin] do
        assert {:error, %Error{reason: :config}} = Config.check_scope(config, api)
      end
    end

    test "matching scopes pass" do
      client = Gleanex.new(domain: "acme", token: "secret")
      indexing = Gleanex.new(domain: "acme", token: "secret", scope: :indexing)

      assert :ok = Config.check_scope(client, :client)
      assert :ok = Config.check_scope(client, :platform)
      assert :ok = Config.check_scope(client, :admin)
      assert :ok = Config.check_scope(indexing, :indexing)
    end
  end

  defp with_app_env(settings, fun) do
    keys = Map.keys(settings)
    previous = Map.new(keys, &{&1, Application.get_env(:gleanex, &1)})

    Enum.each(settings, fn {key, value} -> Application.put_env(:gleanex, key, value) end)

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
