# Gleanex

Elixir client for [Glean](https://www.glean.com), covering all four of Glean's
public APIs. The typed layer is generated from the OpenAPI descriptions Glean
publishes at [gleanwork/open-api](https://github.com/gleanwork/open-api), so it
tracks the real API rather than a hand-picked subset.

## Install

<!-- x-release-please-start-version -->

```elixir
def deps do
  [
    {:gleanex, "~> 0.1.0"}
  ]
end
```

<!-- x-release-please-end -->

Needs Elixir 1.18 or later.

## Use it

```elixir
config = Gleanex.new(domain: "mycompany", token: System.fetch_env!("GLEAN_API_TOKEN"))

{:ok, response} = Gleanex.search(config, "company holidays")
{:ok, answer} = Gleanex.chat(config, "What are the company holidays this year?")
```

`domain` is the backend subdomain Glean gave you, usually your email domain
without the TLD. Requests go to `https://{domain}-be.glean.com`.

With `GLEAN_INSTANCE` and `GLEAN_API_TOKEN` exported you can leave the config
out and each call falls back to the environment.

Inspecting a config does not print its token, so a crash report or a log line
cannot leak it. Read `config.token` when you need the value itself.

Those two shortcuts cover the common case. Everything else is a generated
operation:

```elixir
{:ok, response} =
  Gleanex.Client.Search.search(
    %{query: "holidays", pageSize: 50},
    config: config
  )

{:ok, agents} = Gleanex.Client.Agents.search_agents(%{}, config: config)
{:ok, _} = Gleanex.Admin.Governance.listpolicies(config: config)
```

The config travels in the trailing options, alongside per-call overrides like
`:receive_timeout`, `:retry` and `:req_options`.

## The four APIs

| Namespace | What it covers | Token |
| --- | --- | --- |
| `Gleanex.Client` | search, chat, agents, documents, collections, pins, insights | client |
| `Gleanex.Indexing` | pushing documents, people, groups and permissions into the index | indexing |
| `Gleanex.Platform` | agents, skills and the newer search endpoints | client |
| `Gleanex.Admin` | governance policies, reports, findings, datasource administration | client |

Client and Indexing tokens are not interchangeable. Build one config per scope,
and a mismatched call fails before it leaves your machine:

```elixir
indexing = Gleanex.new(domain: "mycompany", token: indexing_token, scope: :indexing)

{:ok, _} = Gleanex.Indexing.Documents.indexdocument(%{document: document}, config: indexing)
```

## Results

Every operation returns `{:ok, result}` or `{:error, %Gleanex.Error{}}`, never
both. Match on `reason` to tell failures apart:

```elixir
case Gleanex.search(config, "holidays") do
  {:ok, response} ->
    response.results

  {:error, %Gleanex.Error{reason: :rate_limited, retry_after: seconds}} ->
    back_off(seconds)

  {:error, %Gleanex.Error{reason: :problem_detail, problem: problem}} ->
    Logger.error(problem.detail)

  {:error, error} ->
    raise error
end
```

`retry_after` is always a number of seconds, whether Glean sent a delay or a
date.

Successful responses are decoded into structs. Field names are Glean's own
camelCase, matching their documentation, so request maps and response structs
agree with each other:

```elixir
response.trackingToken
response.hasMoreResults
```

## Retries and timeouts

Transient failures are retried by default, honouring `Retry-After` on rate
limits. Change the policy globally or for one call:

```elixir
config = Gleanex.new(domain: "mycompany", token: token, retry: %Gleanex.Retry{max_retries: 5})

Gleanex.search(config, "holidays", retry: Gleanex.Retry.disabled())
Gleanex.search(config, "holidays", receive_timeout: 60_000)
```

## Paging

Cursor-paginated endpoints become a `Stream`:

```elixir
config
|> Gleanex.Pagination.stream(&Gleanex.Client.Search.search/2, %{query: "holidays"})
|> Stream.flat_map(& &1.results)
|> Enum.take(100)
```

## Streaming

Chat and agent runs can be consumed as they arrive:

```elixir
{:ok, chunks} = Gleanex.Streaming.chat(config, %{messages: messages})

{:ok, events} = Gleanex.Streaming.agent_run(config, %{agentId: "abc", input: %{}})

for event <- events do
  case Gleanex.SSE.json_data(event) do
    {:ok, payload} -> handle(payload)
    {:error, _} -> :ok
  end
end
```

The response is delivered to the process that made the request, so consume the
stream in that same process, and only once. Consuming it elsewhere raises
straight away rather than waiting for chunks that cannot arrive.

## Bulk indexing

Bulk uploads are paged, and Glean only swaps in the new batch once it has seen
the last page. `Gleanex.Bulk` drives that protocol:

```elixir
Gleanex.Bulk.upload(
  indexing_config,
  &Gleanex.Indexing.Documents.bulkindexdocuments/2,
  %{datasource: "mydatasource"},
  :documents,
  documents,
  page_size: 500
)
```

## Telemetry

Every request emits a `[:gleanex, :request]` span with `:api`, `:operation`,
`:method`, `:url` and, on stop, `:status`.

## Working on Gleanex

The typed layer is generated and committed, so users need no Java, no Docker and
no generator dependency.

```sh
mix glean.specs      # download Glean's descriptions into priv/openapi/
mix glean.gen        # regenerate lib/gleanex/{client,indexing,platform,admin}/
mix test --cover     # the suite, at an enforced 100% threshold
```

`priv/openapi/.api-version` records the exact upstream commit the committed code
came from. Regeneration is deterministic: with unchanged descriptions it should
leave the working tree clean.

Descriptions are taken from `source_specs/` upstream, not `final_specs/`. The
latter has code samples merged in, which inflates the Client API description
from under 400 KB to about 19 MB without adding anything a generator can use.

Do not hand-edit anything under `lib/gleanex/client`, `lib/gleanex/indexing`,
`lib/gleanex/platform` or `lib/gleanex/admin`. Naming and rendering are steered
from `config/config.exs` and the plugin in `dev/gleanex/generator/processor.ex`.

### Git hooks

`mix deps.get` followed by `mix git_hoox.install` writes two hooks. They run the
same checks CI does, split by how long they take:

- **pre-commit** — `mix format --check-formatted` and `mix credo --strict`.
- **pre-push** — `mix compile --warnings-as-errors` and `mix test --cover`.

Dialyzer is in neither. Its first run builds a PLT that takes minutes, which is
too long to sit in front of a push, so CI runs it on a cached PLT instead.

Skip a hook with `git commit --no-verify` or `git push --no-verify`. The tasks
live in `.git_hoox.exs` at the repository root; re-run `mix git_hoox.install`
after changing them.

### Integration tests

The suite runs against stubs, which prove the library does what Gleanex expects
of it, not that this is what Glean expects. A wrong path prefix or a field name
that no longer matches the description would pass every stubbed test.

A separate read-only smoke test covers that, against a real deployment. It is
excluded unless asked for:

```sh
GLEAN_INSTANCE=mycompany GLEAN_API_TOKEN=... mix test --include integration
```

It only reads, and only through the Client API. The Indexing API writes to a
real search index, and a bulk upload replaces the previous batch, so it is left
to the stubbed tests rather than pointed at a live deployment.

### Releasing

Releases are driven by [release-please](https://github.com/googleapis/release-please),
run through [release-mate](https://github.com/release-mate/action) with a
short-lived GitHub App token.

Every Conventional Commit landed on `main` is collected into a release pull
request that stays open and updates itself. Merging it bumps `@version` in
`mix.exs`, rewrites `CHANGELOG.md`, updates the version in the install snippet
above, tags the commit `vX.Y.Z` and cuts the GitHub release. Nothing to run by
hand, and no version to remember to bump.

The install snippet is kept in step by the `x-release-please-start-version` and
`x-release-please-end` comments around it, with `README.md` listed under
`extra-files` in `release-please-config.json`. Any version number between those
two comments is rewritten on release, so keep unrelated versions out of that
block.

Which commits appear in the changelog follows `release-please-config.json`:
`feat`, `fix`, `perf` and `revert` are listed, everything else is recorded but
hidden. `bump-minor-pre-major` keeps breaking changes inside `0.x` rather than
jumping to `1.0.0`, and `initial-version` makes the very first release `0.1.0`
rather than release-please's default of `1.0.0`.

Cutting the GitHub release triggers `.github/workflows/publish.yml`, which runs
`mix hex.publish --yes`. It needs a `HEX_API_KEY` secret.

That makes merging the release pull request the point of no return: a Hex
version can never be reused or withdrawn, only deprecated.

## Licence

BSD 2-Clause. Gleanex is not affiliated with or endorsed by Glean.
