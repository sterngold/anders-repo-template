# anders-repo-template

> Model-agnostic baseline for every repo in the House of Anders.
> One template, every AI agent (Claude Code, Codex, Cursor, Aider, Gemini, Continue, Cline) reads the same conventions.

## What's inside

- **AGENTS.md** — single source of truth for repo conventions ([agents.md](https://agents.md/) standard)
- **CLAUDE.md / .cursorrules / .aider.conf.yml** — one-line pointers to AGENTS.md, zero duplication
- **.pre-commit-config.yaml + .gitleaks.toml** — secret scanning, line endings, conventional-commits enforcement
- **.github/workflows/ci.yml** — polyglot CI (auto-detects Python / Node / Swift), commitlint, gitleaks
- **.github/workflows/release-please.yml** — automated SemVer + CHANGELOG from Conventional Commits
- **.github/dependabot.yml** — weekly grouped dependency updates
- **.editorconfig / .gitattributes / .gitignore** — universal hygiene
- **Makefile** — `make install / build / test / lint / fmt` works across stacks
- **scripts/** — `new-repo.sh`, `apply-baseline.sh`, `protect-branch.sh`

`release-please` also requires the repository setting that permits GitHub
Actions to create pull requests. See [docs/template-usage.md](./docs/template-usage.md).

## Quick start

**New repo:**
```bash
./scripts/new-repo.sh my-new-app "Short description"
```

**Retro-fit an existing repo:**
```bash
cd /path/to/existing/repo
git checkout -b chore/apply-anders-baseline
curl -sSL https://raw.githubusercontent.com/sterngold/anders-repo-template/main/scripts/apply-baseline.sh | bash
```

See [docs/template-usage.md](./docs/template-usage.md) for the full guide.

## Why

See [AGENTS.md](./AGENTS.md). The short version: repo conventions belong in the repo, not in a per-tool config file. Every modern AI coding agent reads `AGENTS.md`. Write once, every model obeys.

## License

Source available for reference. No reuse license is granted unless you receive written permission; see [LICENSE](./LICENSE).
