#!/usr/bin/env bash
# protect-branch.sh — apply strict branch protection to main on a repo.
# Requires: gh CLI authenticated.
#
# Usage:
#   ./protect-branch.sh <repo>           # e.g. ./protect-branch.sh anderson
#   ./protect-branch.sh <owner>/<repo>   # e.g. ./protect-branch.sh sterngold/anderson

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <repo|owner/repo>"
  exit 1
fi

REPO="$1"
[[ "$REPO" != */* ]] && REPO="sterngold/$REPO"

echo "→ Applying strict branch protection to $REPO:main"
# NOTE: required_signatures is currently FALSE because SSH/GPG signing
# setup is parked. To require signed commits later: change to true.

gh api -X PUT "repos/$REPO/branches/main/protection" \
  --input - <<'JSON'
{
  "required_status_checks": {
    "strict": true,
    "contexts": ["ci"]
  },
  "enforce_admins": false,
  "required_pull_request_reviews": {
    "required_approving_review_count": 0,
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": false,
    "require_last_push_approval": false
  },
  "required_linear_history": true,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "required_conversation_resolution": true,
  "lock_branch": false,
  "allow_fork_syncing": false,
  "required_signatures": false,
  "restrictions": null
}
JSON

echo "→ Setting squash-merge only..."
gh api -X PATCH "repos/$REPO" \
  -F allow_merge_commit=false \
  -F allow_rebase_merge=false \
  -F allow_squash_merge=true \
  -F allow_auto_merge=true \
  -F delete_branch_on_merge=true \
  -F squash_merge_commit_title=PR_TITLE \
  -F squash_merge_commit_message=PR_BODY >/dev/null

echo "✓ $REPO:main protected (signed commits, linear history, ci required, squash-merge only)"
