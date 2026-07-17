#!/usr/bin/env bash
# apply-baseline.sh — copy baseline files from anders-repo-template into an existing repo.
#
# Usage: from inside the target repo:
#   curl -sSL https://raw.githubusercontent.com/sterngold/anders-repo-template/main/scripts/apply-baseline.sh | bash
# Or:
#   git clone git@github.com:sterngold/anders-repo-template.git /tmp/art
#   cd /your/repo && /tmp/art/scripts/apply-baseline.sh
#
# Idempotent: skips files that already exist (use --force to overwrite).
set -euo pipefail

FORCE=0
[ "${1:-}" = "--force" ] && FORCE=1

TEMPLATE_DIR="${TEMPLATE_DIR:-}"
if [ -z "$TEMPLATE_DIR" ]; then
  TMP=$(mktemp -d)
  echo "→ Cloning anders-repo-template..."
  git clone --depth 1 git@github.com:sterngold/anders-repo-template.git "$TMP"
  TEMPLATE_DIR="$TMP"
fi

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "✗ Not inside a git repo. cd into the target repo first."
  exit 1
fi

FILES=(
  AGENTS.md
  CLAUDE.md
  .cursorrules
  .aider.conf.yml
  .editorconfig
  .gitattributes
  .pre-commit-config.yaml
  .gitleaks.toml
  .commitlintrc.json
  .env.example
  CHANGELOG.md
  .github/CODEOWNERS
  .github/copilot-instructions.md
  .github/pull_request_template.md
  .github/dependabot.yml
  .github/ISSUE_TEMPLATE/bug.md
  .github/ISSUE_TEMPLATE/feature.md
  .github/workflows/ci.yml
  .github/workflows/release-please.yml
  release-please-config.json
  .release-please-manifest.json
)

copied=0
skipped=0
for f in "${FILES[@]}"; do
  if [ -f "$f" ] && [ "$FORCE" -eq 0 ]; then
    echo "  skip   $f (exists — pass --force to overwrite)"
    skipped=$((skipped + 1))
    continue
  fi
  mkdir -p "$(dirname "$f")"
  cp "$TEMPLATE_DIR/$f" "$f"
  echo "  ✓ copy $f"
  copied=$((copied + 1))
done

echo
echo "Done. Copied: $copied, Skipped: $skipped"
echo
echo "Next:"
echo "  1. Edit AGENTS.md → fill in repo name, purpose, stack, build/test commands"
echo "  2. Edit README.md (template did NOT overwrite if it exists)"
echo "  3. pre-commit install"
echo "  4. git checkout -b chore/apply-anders-baseline"
echo "  5. git add -A && git commit -m 'chore: apply Anders repo baseline'"
echo "  6. gh pr create --fill"
echo "  7. After merge: ../anders-repo-template/scripts/protect-branch.sh <repo>"
