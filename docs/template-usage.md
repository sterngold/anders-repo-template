# How to use anders-repo-template

## Create a new repo from this template

**Option A — script (recommended):**
```bash
./scripts/new-repo.sh my-new-app "Short description"
```

**Option B — gh CLI directly:**
```bash
gh repo create sterngold/my-new-app \
  --template sterngold/anders-repo-template \
  --private --clone
```

**Option C — GitHub UI:**
Go to the template repo on github.com → "Use this template" → "Create a new repository".

## Retro-fit an existing repo

From inside the target repo:
```bash
git checkout -b chore/apply-anders-baseline
curl -sSL https://raw.githubusercontent.com/sterngold/anders-repo-template/main/scripts/apply-baseline.sh | bash
# Edit AGENTS.md, README.md to repo specifics
pre-commit install
git add -A && git commit -m "chore: apply Anders repo baseline"
gh pr create --fill
```

After the PR merges, apply branch protection:
```bash
/path/to/anders-repo-template/scripts/protect-branch.sh <repo-name>
```

## What's enforced

| Check | How |
|---|---|
| Conventional Commit titles on PRs | commitlint via GitHub Action |
| No secrets in commits | gitleaks pre-commit + CI |
| Lint + test pass | language-specific jobs in ci.yml |
| Signed commits on main | branch protection |
| No force-push to main | branch protection |
| No direct commits to main | branch protection (PR required) |
| Linear history | branch protection (squash-merge only) |
| Auto-generated CHANGELOG + version bumps | release-please |
| Weekly dependency updates | dependabot |

## Per-repo customization

The template ships polyglot defaults. Per-repo:
- **AGENTS.md** — fill in stack, build/test commands
- **Makefile** — adjust targets if needed
- **.pre-commit-config.yaml** — uncomment ruff (Python) or prettier (JS/TS) blocks
- **.github/dependabot.yml** — uncomment pip/npm/swift block matching the repo
- **release-please-config.json** — change `release-type` from `simple` to `python` / `node` if you want auto-version-bumping in source files
