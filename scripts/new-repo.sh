#!/usr/bin/env bash
# new-repo.sh — create a new private repo from anders-repo-template.
#
# Usage:
#   ./new-repo.sh <name> "<description>"

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <name> [description]"
  exit 1
fi

NAME="$1"
DESC="${2:-}"

echo "→ Creating sterngold/$NAME from template..."
gh repo create "sterngold/$NAME" \
  --template sterngold/anders-repo-template \
  --private \
  ${DESC:+--description "$DESC"} \
  --clone

cd "$NAME"

echo "→ Applying branch protection..."
"$(dirname "$0")/protect-branch.sh" "$NAME" || \
  echo "  (skipped — initial commit needed first; run protect-branch.sh after first push)"

echo
echo "✓ Repo ready at $(pwd)"
echo "Next:"
echo "  1. Edit AGENTS.md (fill in stack + commands)"
echo "  2. Edit README.md"
echo "  3. pre-commit install"
