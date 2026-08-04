# Changelog

## 0.1.0

First release.

- Generated coverage of all four Glean APIs: Client, Indexing, Platform and
  Admin, from `gleanwork/open-api`. `priv/openapi/.api-version` records the
  exact upstream commit the shipped code was generated from, and is updated
  whenever the descriptions are.
- `Gleanex.Config` with per-scope tokens, domain templating and per-API path
  prefixes. Client and Indexing token mix-ups fail before a request is sent.
- `Gleanex.HTTP` transport on Req, with bearer auth, JSON and multipart bodies,
  retries that honour `Retry-After`, and `[:gleanex, :request]` telemetry spans.
- `Gleanex.Error`, one struct for every failure, including RFC 7807 problem
  details.
- `Gleanex.Pagination` for cursor-paginated endpoints.
- `Gleanex.Streaming` for chat and agent runs, with `Gleanex.SSE` and
  `Gleanex.NDJSON` decoders.
- `Gleanex.Bulk` for the paged bulk indexing protocol.
- `mix glean.specs` and `mix glean.gen` to vendor descriptions and regenerate.
