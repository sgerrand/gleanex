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
