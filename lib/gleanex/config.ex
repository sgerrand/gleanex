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

  There are only those two families. The Platform and Admin APIs are reached
  with a Client token, so `:client` covers three of the four.

  ## Scope here is not Glean's permission scopes

  `:scope` records which family of token you hold, which is all Gleanex can
  check on its own. Glean separately puts *permission scopes* on a token, and
  those decide which endpoints it may call. Gleanex cannot see them, so a token
  of the right family with the wrong permissions still fails at Glean, as a 403.

  The Admin API is where this bites, because a Client token that searches
  perfectly well is not enough on its own:

    * policies and reports need the `DATA_GOVERNANCE` scope, on a token
      belonging to someone who can reach the Sensitive Content pages
    * visibility overrides need `CONTENT_HIDING`, typically a super admin

  Scopes are set when the token is created, in Glean's admin console.

  ## Where settings come from

  Highest precedence first:

  1. options passed to `new/1`
  2. application environment under `:gleanex`
  3. the `GLEAN_API_TOKEN`, `GLEAN_INSTANCE` and `GLEAN_BASE_URL` environment
     variables, holding `:token`, `:domain` and `:base_url` respectively

      config :gleanex,
        domain: "mycompany",
        token: {:system, "GLEAN_API_TOKEN"}

  Only those three have an environment variable. Every other setting comes from
  `new/1` or the application environment.

  ## Domain and base URL

  Glean serves each customer from `https://{domain}-be.glean.com`, where `domain`
  is usually the email domain without the TLD. The four APIs then live under
  different path prefixes, which this module appends for you.

  `:base_url` overrides the host root only — give it scheme and host with no
  path, for example `https://mycompany-be.glean.com`. The per-API prefix is
  still appended, so anything else is rejected by `new/1` rather than left to
  produce a URL that does not exist.

  When the requests really do need a prefix of their own, as they do through a
  proxy, pass it as a `Req` option instead. That replaces the whole base URL,
  prefix included:

      Gleanex.new(domain: "mycompany", token: token,
        req_options: [base_url: "https://proxy.internal/glean/rest/api/v1"])

  ## Connection pooling

  `Req` shares one automatically started connection pool across the whole node,
  so every config here uses the same one by default. A long bulk index run can
  therefore hold connections that interactive searches are waiting for.

  Pass a `Finch` instance of your own to keep the two apart:

      Gleanex.new(domain: "mycompany", token: indexing_token, scope: :indexing,
        req_options: [finch: [name: MyApp.IndexingPool]])

  The instance has to be started in your supervision tree. The same option
  carries the pool's connection limits, and `:connect_options` sets the connect
  timeout, which `:receive_timeout` does not cover.

  ## The token is hidden from inspect

  Inspecting a config does not print its token, so a crash report, a log line or
  an error tracker cannot leak the credential:

      iex> config = Gleanex.new(domain: "mycompany", token: "secret")
      iex> inspect(config) =~ "secret"
      false

  Read `config.token` to get at it. This only affects `inspect/1`; the token is
  an ordinary field otherwise.
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

  # The token is kept out of `inspect/1`. A config reaches an inspect call more
  # often than it looks: a crash report prints the arguments of every frame, and
  # error trackers and dashboards print process state. Redacting here means none
  # of those leak a credential.
  @derive {Inspect, except: [:token]}
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
      accepted as an alias, matching the Go SDK's `WithInstance`. Defaults to
      `GLEAN_INSTANCE`.
    * `:base_url` - host root override, skipping domain templating. Defaults to
      `GLEAN_BASE_URL`.
    * `:token` - API token. Defaults to `GLEAN_API_TOKEN`.
    * `:scope` - `:client` (default) or `:indexing`.
    * `:retry` - a `Gleanex.Retry` policy. Left alone, the condition is chosen
      per API, and Indexing gets a narrower one than the rest because it writes.
    * `:receive_timeout` - milliseconds to wait for a response, default `30_000`.
    * `:req_options` - options passed straight through to `Req`. `:headers` and
      `:params` are merged with the ones Gleanex sets rather than replacing
      them; see `Gleanex.HTTP.build_request/3`.

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

  defp validate!(%__MODULE__{base_url: base_url} = config) when is_binary(base_url) do
    if host_root?(base_url) do
      config
    else
      raise Error.config(
              "invalid :base_url #{inspect(base_url)}: give scheme and host only, for example " <>
                "\"https://mycompany-be.glean.com\". Each API's path prefix is appended to it, " <>
                "so a :base_url carrying a path of its own produces a URL that does not exist. " <>
                "To send requests through something that does need a prefix, such as a proxy, " <>
                "pass req_options: [base_url: ...] instead, which replaces the whole URL"
            )
    end
  end

  defp validate!(%__MODULE__{} = config), do: config

  # A trailing slash is already trimmed by the time this runs, so the path of a
  # bare host is nil rather than "/".
  defp host_root?(base_url) do
    case URI.new(base_url) do
      {:ok, %URI{scheme: scheme, host: host, path: path, query: nil, fragment: nil}} ->
        scheme in ["http", "https"] and is_binary(host) and host != "" and path in [nil, ""]

      _ ->
        false
    end
  end

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
    host <> prefix(api)
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

  This is about which *family* of token you hold, which is the part that can be
  settled without asking Glean. It says nothing about whether that token carries
  the permission scopes an endpoint needs; see the moduledoc.
  """
  @spec check_scope(t, api) :: :ok | {:error, Error.t()}
  def check_scope(%__MODULE__{scope: scope}, api) do
    case expected_scope(api) do
      ^scope ->
        :ok

      expected ->
        {:error,
         Error.config(
           "this config holds #{article(scope)} #{scope} token but the #{api} API needs " <>
             "#{article(expected)} #{expected} token. Client and Indexing tokens are not " <>
             "interchangeable; build a second config with " <>
             "Gleanex.new(scope: #{inspect(expected)}, ...)"
         )}
    end
  end

  # Platform and Admin fall to :client deliberately, not by omission. Glean
  # issues two families of token, Client and Indexing, and there is no third:
  # the Admin API is Glean's Governance API, served from the same host under
  # `/rest/api/v1` like the Client API, and its documentation says to call it
  # with a Client API token. What Admin additionally needs is a permission scope
  # on that token, which is a different axis; see the moduledoc.
  #
  # The Admin description asks for `actAsBearerToken` and `cookieAuth` and then
  # defines neither, so it cannot settle this on its own.
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
