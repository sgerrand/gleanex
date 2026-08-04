# Integration tests talk to a real Glean deployment and need credentials, so
# they are opt-in:
#
#     mix test --include integration
#
ExUnit.start(exclude: [:integration])
