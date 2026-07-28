defmodule Gleanex.Config do
  @moduledoc """
  Connection settings for a Glean deployment.

  A config carries the backend domain, an API token and the transport knobs used
  for every request made with it.

  ## Tokens are scoped

  Glean issues separate tokens for the Client and Indexing APIs, and they are not
  interchangeable. Build one config per scope:

      client = Gleanex.new(domain: "mycompany", token: client_token)
      indexing = Gleanex.new(domain: "mycompany", token: indexing_token, scope: :indexing)

  Using the wrong scope fails before the request is sent, with a clear message
  rather than an opaque 401.

  ## Where settings come from

  Highest precedence first:

  1. options passed to `new/1`
  2. application environment under `:gleanex`
  3. the `GLEAN_API_TOKEN` and `GLEAN_INSTANCE` environment variables

      config :gleanex,
        domain: "mycompany",
        token: {:system, "GLEAN_API_TOKEN"}

  ## Domain and base URL

  Glean serves each customer from `https://{domain}-be.glean.com`, where `domain`
  is usually the email domain without the TLD. The four APIs then live under
  different path prefixes, which this module appends for you.

  `:base_url` overrides the host root only — always give it scheme and host with
  no path, for example `https://mycompany-be.glean.com`. The per-API prefix is
  still appended.
  """

  alias Gleanex.Error
  alias Gleanex.Retry

  @typedoc "One of the four Glean APIs."
  @type api :: :client | :indexing | :platform | :admin

  @typedoc "Which family of token this config holds."
  @type scope :: :client | :indexing

  @type t :: %__MODULE__{
          domain: String.t() | nil,
          base_url: String.t() | nil,
          token: String.t(),
          scope: scope,
          retry: Retry.t(),
          receive_timeout: timeout,
          req_options: keyword
        }

  defstruct domain: nil,
            base_url: nil,
            token: nil,
            scope: :client,
            retry: %Retry{},
            receive_timeout: 30_000,
            req_options: []

  @api_prefixes %{
    client: "/rest/api/v1",
    indexing: "/api/index/v1",
    platform: "/api",
    admin: "/rest/api/v1"
  }

  @apis Map.keys(@api_prefixes)
  @scopes [:client, :indexing]

  @doc """
  Build a config.

  Raises `Gleanex.Error` when the token is missing, or when neither `:domain`
  nor `:base_url` can be resolved.

  ## Options

    * `:domain` - backend subdomain, for example `"mycompany"`. `:instance` is
      accepted as an alias, matching the Go SDK's `WithInstance`.
    * `:base_url` - host root override, skipping domain templating.
    * `:token` - API token. Defaults to `GLEAN_API_TOKEN`.
    * `:scope` - `:client` (default) or `:indexing`.
    * `:retry` - a `Gleanex.Retry` policy.
    * `:receive_timeout` - milliseconds to wait for a response, default `30_000`.
    * `:req_options` - options passed straight through to `Req`.

  """
  @spec new(keyword) :: t
  def new(opts \\ []) do
    domain = resolve(opts, [:domain, :instance], "GLEAN_INSTANCE")
    base_url = resolve(opts, [:base_url], "GLEAN_BASE_URL")

    config = %__MODULE__{
      domain: domain,
      base_url: base_url && String.trim_trailing(base_url, "/"),
      token: resolve(opts, [:token], "GLEAN_API_TOKEN"),
      scope: setting(opts, :scope, :client),
      retry: setting(opts, :retry, %Retry{}),
      receive_timeout: setting(opts, :receive_timeout, 30_000),
      req_options: setting(opts, :req_options, [])
    }

    validate!(config)
  end

  defp setting(opts, key, default), do: Keyword.get(opts, key) || fetch_env(key) || default

  defp validate!(%__MODULE__{token: token}) when not is_binary(token) or token == "" do
    raise Error.config(
            "missing Glean API token: pass :token to Gleanex.new/1, set config :gleanex, " <>
              "token: ..., or export GLEAN_API_TOKEN"
          )
  end

  defp validate!(%__MODULE__{domain: nil, base_url: nil}) do
    raise Error.config(
            "missing Glean domain: pass :domain to Gleanex.new/1, set config :gleanex, " <>
              "domain: ..., or export GLEAN_INSTANCE"
          )
  end

  defp validate!(%__MODULE__{scope: scope}) when scope not in @scopes do
    raise Error.config("invalid :scope #{inspect(scope)}, expected one of #{inspect(@scopes)}")
  end

  defp validate!(%__MODULE__{} = config), do: config

  @doc """
  Build a config from the application environment and system environment alone.

  Used when an operation is called without an explicit `:config` option.
  """
  @spec default() :: t
  def default, do: new([])

  @doc """
  The full base URL for one of the four APIs, including its path prefix.

      iex> config = Gleanex.new(domain: "mycompany", token: "t")
      iex> Gleanex.Config.base_url(config, :client)
      "https://mycompany-be.glean.com/rest/api/v1"
      iex> Gleanex.Config.base_url(config, :indexing)
      "https://mycompany-be.glean.com/api/index/v1"

  """
  @spec base_url(t, api) :: String.t()
  def base_url(%__MODULE__{} = config, api) when api in @apis do
    host = config.base_url || "https://#{config.domain}-be.glean.com"
    host <> Map.fetch!(@api_prefixes, api)
  end

  @doc """
  The path prefix for an API, without the host.
  """
  @spec prefix(api) :: String.t()
  def prefix(api) when api in @apis, do: Map.fetch!(@api_prefixes, api)

  @doc """
  The list of known APIs.
  """
  @spec apis() :: [api]
  def apis, do: @apis

  @doc """
  Check that this config's token scope can be used against `api`.

  Only the documented hard rule is enforced: Indexing tokens work against the
  Indexing API and nothing else, and Client tokens work everywhere except the
  Indexing API.
  """
  @spec check_scope(t, api) :: :ok | {:error, Error.t()}
  def check_scope(%__MODULE__{scope: :indexing}, :indexing), do: :ok

  def check_scope(%__MODULE__{scope: scope}, api) when scope != :indexing and api != :indexing,
    do: :ok

  def check_scope(%__MODULE__{scope: scope}, api) do
    expected = expected_scope(api)

    {:error,
     Error.config(
       "this config holds #{article(scope)} #{scope} token but the #{api} API needs " <>
         "#{article(expected)} #{expected} token. Client and Indexing tokens are not " <>
         "interchangeable; build a second config with Gleanex.new(scope: #{inspect(expected)}, ...)"
     )}
  end

  defp expected_scope(:indexing), do: :indexing
  defp expected_scope(_), do: :client

  defp article(:indexing), do: "an"
  defp article(_), do: "a"

  defp resolve(opts, keys, env_var) do
    Enum.find_value(keys, fn key -> normalise(Keyword.get(opts, key)) end) ||
      Enum.find_value(keys, fn key -> normalise(fetch_env(key)) end) ||
      normalise(System.get_env(env_var))
  end

  defp fetch_env(key), do: Application.get_env(:gleanex, key)

  defp normalise(nil), do: nil
  defp normalise(""), do: nil
  defp normalise({:system, var}), do: normalise(System.get_env(var))
  defp normalise(value), do: value
end
