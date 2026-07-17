# GitHub Copilot instructions

Read the repository-root `AGENTS.md`, `CLAUDE.md`, and `README.md` before doing
any work. `AGENTS.md` is the model-agnostic source of truth. Use only
repository-relative paths and checked-in context; never depend on a user's home
directory during cloud execution.

## Repository commands

This repository is the polyglot baseline template, not an instantiated
application. Its current Make targets auto-detect manifests, so these commands
are intentional no-ops for build, lint, and test in the template checkout:

```bash
make build
make lint
make test
```

The repository's real shell lint command is:

```bash
shellcheck scripts/*.sh
```

CI also runs Conventional Commit validation and gitleaks. Do not invent an
application stack or replace template placeholders with assumptions. The
required aggregate GitHub check is `ci`; it must pass before merge.

## Working rules

- Work on a new task-named branch in an isolated checkout or worktree. Never
  push code directly to `main`.
- Keep changes template-safe across supported stacks. Stage narrowly using only reviewed paths,
  use Conventional Commits, and do not bypass hooks.
- Do not add a new top-level dependency or change a dependency manifest or
  lockfile without explicit approval. If approved dependency work is
  required, preserve lockfile discipline and do not enable new install lifecycle
  scripts implicitly.
- Stop when required local-only policy, credentials, or instantiated-repository
  context is unavailable; do not invent values for the `<NAME>`, stack, host, or
  command placeholders.
- Before merge, wait for CI and resolve every review thread. Copilot review is
  advisory; it does not replace CI or human merge approval.

## Review priorities

Prioritize silent failures, boundary validation, tests, security, and unresolved
review threads. Also check dependency safety and portability of generated
repositories.
