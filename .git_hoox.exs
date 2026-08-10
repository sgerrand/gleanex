# Local git hooks, run by git_hoox. These mirror the CI jobs in
# .github/workflows/ci.yml, split by how long they take: the cheap checks run on
# every commit, the slow ones only when work leaves the machine.
#
# Dialyzer is left out of both. Its first run builds a PLT that takes minutes,
# which is too much to put in front of a push; CI runs it on its own cached PLT
# instead.
#
# Install the hooks with `mix git_hoox.install`, and re-run it after changing
# this file. Skip a hook with `git commit --no-verify` / `git push --no-verify`.
%{
  hooks: [
    pre_commit: [
      # Both are seconds on an already-compiled tree, and both fail for reasons
      # the author can fix on the spot. check_only, so a formatting problem is
      # reported rather than rewritten underneath the commit.
      {GitHoox.Hooks.Format, check_only: true},
      # The default timeout is 30 seconds, which a commit touching a large slice
      # of the generated tree can outrun.
      {GitHoox.Hooks.Credo, strict: true, timeout: 120_000},
      # Markdown lint. It checks the whole tree rather than the staged files,
      # but the files glob keeps it out of the way of commits that touch no
      # Markdown. Needs mado on PATH; without it the hook fails.
      {GitHoox.Hooks.Shell, run: "mado check .", files: ["**/*.md"]}
    ],
    pre_push: [
      # Shell, not the dedicated hooks: the compile flags and `mix test --cover`
      # have no equivalent option on GitHoox.Hooks.Test, which only chooses
      # between the whole suite, --stale and related files.
      {GitHoox.Hooks.Shell, run: "mix compile --warnings-as-errors", timeout: 300_000},
      # --cover, not plain `mix test`: the 100% threshold in mix.exs is only
      # enforced with it, and that is the check worth having here.
      {GitHoox.Hooks.Shell, run: "mix test --cover", timeout: 600_000}
    ]
  ],
  # Stop at the first failure, so the output ends on the thing to fix.
  fail_fast: true
}
