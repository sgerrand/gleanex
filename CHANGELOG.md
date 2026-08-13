# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0](https://github.com/sgerrand/gleanex/compare/gleanex-v0.1.0...gleanex-v0.2.0) (2026-08-13)


### Features

* **streaming:** fail fast when a stream is consumed elsewhere ([e14908e](https://github.com/sgerrand/gleanex/commit/e14908e067ca36e09d7134597028a5bd6b353829))


### Bug Fixes

* **config:** keep the API token out of inspect output ([48ad159](https://github.com/sgerrand/gleanex/commit/48ad159bb2c026c5cea59905633548724e51d2a3))
* **config:** reject a :base_url that is not a bare host root ([a040199](https://github.com/sgerrand/gleanex/commit/a0401998f7550846b097a24dadecb7dfae0938d3))
* **docs:** hide internal modules with ex_doc's actual option ([#12](https://github.com/sgerrand/gleanex/issues/12)) ([7958f6e](https://github.com/sgerrand/gleanex/commit/7958f6e654e2f6d391fc00129359f8c1b4069b5a))
* **error:** drop the placeholder arity from error messages ([acef61c](https://github.com/sgerrand/gleanex/commit/acef61c94276bd64a75bf94f505357f01f03ed1c))
* **error:** read a Retry-After date as a delay in seconds ([b70ad00](https://github.com/sgerrand/gleanex/commit/b70ad00bbce4956f1c35fcb8d4d563b3ba40207f))
* merge req_options headers and params by name ([#11](https://github.com/sgerrand/gleanex/issues/11)) ([33124c9](https://github.com/sgerrand/gleanex/commit/33124c9ceba4d649e02b877fb29112f2ddc25bf9))
* stop retrying Indexing writes that may already have landed ([#16](https://github.com/sgerrand/gleanex/issues/16)) ([6b86ca1](https://github.com/sgerrand/gleanex/commit/6b86ca1b7c6dd5381cead0feb86d185ac156c91c))

## 0.1.0 (2026-08-05)


### Features

* add code generation tooling and vendor the OpenAPI descriptions ([6eafcdd](https://github.com/sgerrand/gleanex/commit/6eafcdd6694bd3cae3bf916c3f06ae788457333c))
* add core transport, config and error handling ([dbe94f8](https://github.com/sgerrand/gleanex/commit/dbe94f85a14a681a9f5e0f1ee319ab06fc3a89d7))
* add pagination, streaming and bulk indexing helpers ([8a49846](https://github.com/sgerrand/gleanex/commit/8a49846eab17e23f22eb4f1a07b912cc9f3a1597))
* add top-level search and chat shortcuts ([69ad2a9](https://github.com/sgerrand/gleanex/commit/69ad2a94d41e9fbd65fd6c9aa3011ecea66005aa))
* generate clients for all four Glean APIs ([2e30f63](https://github.com/sgerrand/gleanex/commit/2e30f63272dc695457f6a2fdd27be771fc4a0868))


### Bug Fixes

* authenticate the GitHub ref lookup in mix glean.specs ([7f39f91](https://github.com/sgerrand/gleanex/commit/7f39f918bc0cc98b820114b38224925c0cfa23fa))
* **ci:** release 0.1.0 rather than 1.0.0 ([36da6a0](https://github.com/sgerrand/gleanex/commit/36da6a0a288572e5f50a46bb35ce180953aef9a2))
* **ci:** remove empty expression from spec-update comment ([55bd91b](https://github.com/sgerrand/gleanex/commit/55bd91ba584a3f7558cfbdbd1b2c18650d81bc81))
* **specs:** authenticate the GitHub ref lookup ([ab266c1](https://github.com/sgerrand/gleanex/commit/ab266c155d194225b0b23225929c84e2a74a89a5))
