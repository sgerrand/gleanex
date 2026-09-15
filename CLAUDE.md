# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Commands

```sh
mix deps.get
mix compile --warnings-as-errors
mix test --cover          # 100% threshold, enforced; plain `mix test` skips the check
mix format
mix credo --strict
mix dialyzer
mix docs
```

`mix git_hoox.install` writes git hooks via `git_hoox`, configured in
`.git_hoox.exs` at the repository root. pre-commit runs
`mix format --check-formatted`, `mix credo --strict`,
`mix deps.unlock --check-unused` and `mado check .`; the first two see
staged files only, and the last two only run when the commit touches
what they check. pre-push runs
`mix compile --warnings-as-errors` and `mix test --cover`. Dialyzer is in
neither, because
building its PLT takes minutes. `--no-verify` skips either. Re-run
`mix git_hoox.install` after changing the task list.

Running a subset:

```sh
mix test test/gleanex/http_test.exs
mix test test/gleanex/http_test.exs:42          # single test by line
mix test --include integration                  # see "Integration tests" below
```

Regenerating the client:

```sh
mix glean.specs           # download Glean's descriptions into priv/openapi/
mix glean.specs --force --ref <sha>
mix glean.gen             # all four profiles
mix glean.gen platform    # one profile
```

## Generated versus hand-written

`lib/gleanex/{client,indexing,platform,admin}/` is generated (534 files, 153
operations) and committed. **Never hand-edit it.** Shape is controlled by
`config/config.exs` and the plugin in `dev/gleanex/generator/processor.ex`; change
those and regenerate.

Everything else under `lib/` is hand-written. Generation is deterministic, and
CI fails if the committed tree does not match `priv/openapi/`.

`dev/` holds everything that builds Gleanex but is not part of it, and never
reaches the package. Two halves, on different `elixirc_paths`:

- `dev/gleanex/generator/processor.ex` is the generator plugin, compiled in
  `:dev` only. It depends on `oapi_generator`, a dev-only dependency, so it
  cannot be compiled anywhere else.
- `dev/mix/tasks/` holds `mix glean.gen` and `mix glean.specs`, compiled in
  `:dev` and `:test`. They are outside `lib/` so they cannot ship: `glean.gen`
  drives `oapi_generator`, which an installed copy does not have, so a shipped
  task would only ever fail. `:test` is on the list because their tests are.

## The transport contract

This is the seam between generated and hand-written code, and understanding it
requires reading `lib/gleanex/http.ex` alongside any generated operation.

Generated operations end in `client.request/1` with an operation map:

```elixir
client.request(%{
  args: ..., call: {Gleanex.Client.Search, :adminsearch},
  url: "/adminsearch", method: :post, body: body, query: query,
  request: [{"application/json", {Gleanex.Client.SearchRequest, :t}}],
  response: [{200, {Gleanex.Client.SearchResponse, :t}}, ...],
  opts: opts
})
```

`Gleanex.HTTP.request/1` is that client. Consequences worth knowing:

- **`:call` decides the base URL.** The second segment of the module name
  (`Gleanex.Indexing.…`) resolves the API and therefore its path prefix. The four
  APIs share a host but sit under different prefixes; see `Gleanex.Config`.
- **Config travels in `opts`, not as a first argument.** `oapi_generator` emits
  `fun(args…, opts \\ [])`, so there is nowhere else to put it. Calls look like
  `Gleanex.Client.Search.search(body, config: config)`. Omitting `:config` falls
  back to `Gleanex.Config.default/0`, which reads the application and system
  environment.
- **`:response` drives decoding.** `Gleanex.Decoder` walks the generated
  `__fields__/1` tables to build structs, falling back to raw maps for anything
  it cannot place.

## Traps

**Generated structs are not JSON-encodable.** They have no `JSON.Encoder`
implementation, so passing one straight to an encoder raises. `Gleanex.Body`
converts structs to maps at the transport boundary and drops their `nil` fields,
which would otherwise be sent as explicit nulls. Plain maps keep their nils, on
the assumption those were written deliberately. Both forms work as request
bodies.

**Field names are Glean's camelCase**, deliberately: `response.trackingToken`,
not `tracking_token`. `output.field_casing: :snake` exists in the generator but
is not used, because request bodies are plain maps that must stay camelCase for
Glean to accept them, and having requests and responses disagree is worse.

**Client and Indexing tokens are not interchangeable.** `Gleanex.Config` carries
a `:scope` and a mismatch fails before a request is sent. Build one config per
scope.

**`test_coverage` nests the threshold under `:summary`.** A top-level
`threshold:` is accepted without complaint and silently ignored.

**Two JSON implementations are live at once.** Ordinary request and response
bodies are encoded and decoded by `Req`, which uses Jason. Everything Gleanex
decodes itself — `Gleanex.NDJSON`, `Gleanex.SSE.json_data/1` and the error body
`Gleanex.Streaming` drains — uses the standard library's `JSON`, which is why
`mix.exs` floors Elixir at 1.18. The two agree on ordinary payloads and can
differ at the edges, so match the surrounding code rather than picking one.

## Tests

Everything except `test/integration/` runs against `Req.Test` stubs.

- `test/support/` holds stand-ins for generated schemas and operations, compiled
  into the app in `:test` only. It also defines `Mix.Tasks.Api.Gen`, occupying a
  name that is free outside `:dev`, so `mix glean.gen` can be tested without the
  real generator.
- `test/gleanex/generated_sweep_test.exs` calls every generated operation and
  reads every schema's field table. It is what keeps the generated tree at 100%
  coverage. It is deliberately shallow: asserting specifics about 153 operations
  would mean restating the descriptions and churning on every regeneration.
- `test/gleanex/generated_test.exs` compares the committed code against
  `priv/openapi/` in both directions, catching a stale regeneration.
- `test/gleanex/framing_test.exs` is the only file using `stream_data`. Chunk
  reassembly is the one place where a boundary bug hides from examples, so the
  properties assert the thing the module exists for: the result depends on the
  bytes, never on where the chunks fall. Generators are bounded on purpose;
  `Gleanex.Framing` concatenates onto a buffer, so an unbounded payload cut into
  hundreds of chunks is quadratic and would make a higher `:max_runs` crawl
  rather than search harder. Runs come from `config/config.exs`: 100 locally,
  1,000 in CI.
- Coverage excludes test scaffolding only; the generated tree is counted in full.

Tests that mutate the application environment, the working directory, `Mix.shell`
or `Req.default_options` are `async: false` — all four are global.

### Integration tests

`test/integration/live_test.exs` hits a real deployment and is excluded unless
asked for:

```sh
GLEAN_INSTANCE=mycompany GLEAN_API_TOKEN=... mix test --include integration
```

Read-only, and Client API only. The Indexing API writes to a live search index
and a bulk upload replaces the previous batch, so **never point a test at it**.

## Specs and releases

`priv/openapi/` holds vendored descriptions; `.api-version` records the upstream
commit. Take them from `source_specs/` upstream, never `final_specs/` — the
latter merges in code samples, inflating the Client description from under 400 KB
to about 19 MB with nothing a generator can use.

A scheduled workflow checks upstream weekly. It gates its pull request on the
*generated client* changing, not the descriptions: every upstream sync rewrites
`info.x-source-commit-sha` whether or not the API moved.

Commit messages must follow Conventional Commits — release-please parses them to
decide version bumps and build the changelog, so the type prefix is functional,
not stylistic. `CHANGELOG.md` is generated; do not hand-edit it.

Releasing is fully automated and ends in an irreversible step. Merging the
release pull request tags the commit and cuts the GitHub release, which triggers
`.github/workflows/publish.yml` and runs `mix hex.publish --yes`. A Hex version
can never be reused or withdrawn, only deprecated, so treat merging that pull
request as the point of no return.

## Known false positives

`mix dialyzer` reports 11 errors in `dev/gleanex/generator/processor.ex`, all
ignored via `.dialyzer_ignore.exs`. Dialyzer cannot see through
`oapi_generator`'s `use OpenAPI.Processor` macro and reports its callbacks as
undefined; they exist and run. The ignore is scoped to that one file so real
warnings still surface.
