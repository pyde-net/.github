#!/bin/bash
# Apply baseline branch protection to `main` across every non-archived
# repo in the pyde-net GitHub organization.
#
# ── What this protects against ────────────────────────────────────────
# - Accidental `git push --force` that rewrites or wipes history
# - Accidental deletion of the `main` branch
# - These are useful even for a solo founder; they save you from
#   yourself, not from a malicious teammate.
#
# ── What this does NOT yet enforce ────────────────────────────────────
# - Required PR before merging        (solo: would just block yourself)
# - Required reviewers                 (no co-founder to review)
# - Required status checks (CI green)  (per-repo CI names vary; add later)
# - Signed commits                     (extra setup; not yet)
# - Linear history                     (preference; not enforced)
#
# When you hire and want stricter rules, edit this script's JSON body
# (or the equivalent in Settings → Branches) to add the requirements.
# All branch protection rules are fully reversible at any time.
#
# ── Prerequisites ─────────────────────────────────────────────────────
# - gh CLI installed and authenticated (`gh auth status`)
# - Token must have `admin:org` and `repo` scopes (your current token
#   covers both — confirmed via gh auth status earlier).
# - Idempotent: safe to re-run (PUT overwrites the rule).
#
# ── Usage ─────────────────────────────────────────────────────────────
#   bash .github/scripts/protect-branches.sh
#
# Optional flags:
#   ORG=other-org bash protect-branches.sh         # target a different org
#   BRANCH=develop bash protect-branches.sh        # protect a different branch
#   DRY_RUN=1 bash protect-branches.sh             # list what would change without applying

set -euo pipefail

ORG="${ORG:-pyde-net}"
BRANCH="${BRANCH:-main}"
DRY_RUN="${DRY_RUN:-0}"

if ! command -v gh >/dev/null 2>&1; then
  echo "Error: gh CLI not installed." >&2
  exit 2
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "Error: gh not authenticated. Run 'gh auth login' first." >&2
  exit 2
fi

echo "Org:    $ORG"
echo "Branch: $BRANCH"
echo "Dry-run: $DRY_RUN"
echo ""

# Pull non-archived repos. The default branch matters — some repos may
# use a different default (e.g. master, develop). We try `$BRANCH` per
# the env var; if a repo doesn't have that branch, skip with a warning.
echo "Listing non-archived repos in $ORG..."
REPOS=$(gh api "orgs/$ORG/repos?type=all&per_page=100" \
  --paginate \
  --jq '.[] | select(.archived == false) | .name' | sort)

if [[ -z "$REPOS" ]]; then
  echo "No non-archived repos found in $ORG." >&2
  exit 1
fi

REPO_COUNT=$(echo "$REPOS" | wc -l | tr -d ' ')
echo "Found $REPO_COUNT non-archived repos. Applying protection to '$BRANCH'..."
echo ""

# Baseline protection: no force-push, no deletion. Everything else
# stays null/false until you actually want it.
PROTECTION_BODY=$(jq -n '{
  required_status_checks: null,
  enforce_admins: false,
  required_pull_request_reviews: null,
  restrictions: null,
  allow_force_pushes: false,
  allow_deletions: false,
  required_conversation_resolution: false,
  required_linear_history: false,
  block_creations: false
}')

APPLIED=0
SKIPPED=0
FAILED=0

while IFS= read -r REPO; do
  printf "  %-30s " "$ORG/$REPO"

  # Check the branch exists before trying to protect it
  if ! gh api "repos/$ORG/$REPO/branches/$BRANCH" >/dev/null 2>&1; then
    echo "(no '$BRANCH' branch — skipping)"
    SKIPPED=$((SKIPPED + 1))
    continue
  fi

  if [[ "$DRY_RUN" == "1" ]]; then
    echo "would apply (dry-run)"
    continue
  fi

  if gh api -X PUT "repos/$ORG/$REPO/branches/$BRANCH/protection" \
    --input - <<<"$PROTECTION_BODY" >/dev/null 2>&1; then
    echo "protected"
    APPLIED=$((APPLIED + 1))
  else
    echo "FAILED"
    FAILED=$((FAILED + 1))
  fi
done <<<"$REPOS"

echo ""
if [[ "$DRY_RUN" == "1" ]]; then
  echo "Dry-run complete. Re-run without DRY_RUN=1 to apply."
else
  echo "Done. Protected: $APPLIED, skipped: $SKIPPED, failed: $FAILED"
fi

echo ""
echo "To verify a specific repo: gh api repos/$ORG/<repo>/branches/$BRANCH/protection"
echo "To remove protection:     gh api -X DELETE repos/$ORG/<repo>/branches/$BRANCH/protection"
