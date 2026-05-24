#!/bin/bash
# Create the canonical Pyde Slack workspace structure.
#
# This script is idempotent — channels that already exist are skipped,
# not failed. Safe to re-run after partial failures or to add channels
# you defined here later.
#
# ── Prerequisites ─────────────────────────────────────────────────────
#
# 1. Create a one-shot Slack app at https://api.slack.com/apps
#    - "From scratch" -> name "Pyde Workspace Bootstrap" or similar
#    - Pick your Pyde workspace
#
# 2. Add OAuth scopes (User Token Scopes, NOT Bot Token Scopes — User
#    token has the permissions needed to create channels as you):
#      - channels:manage
#      - groups:write
#      - channels:write.topic
#      - channels:write.invites
#
# 3. Install the app to your workspace (Install App -> Allow)
#
# 4. Copy the "User OAuth Token" (starts with `xoxp-...`)
#
# 5. From this repo's root, run:
#      SLACK_TOKEN=xoxp-your-token bash .github/scripts/create-slack-channels.sh
#
# 6. After the channels exist, you can delete the bootstrap Slack app
#    at https://api.slack.com/apps (it never needs to touch your
#    workspace again). The channels persist.
#
# ── Requirements ──────────────────────────────────────────────────────
# bash, curl, jq.  Install jq if missing: brew install jq
#
# ── Channel structure ─────────────────────────────────────────────────
# See .github/SLACK_WORKSPACE.md for the human-readable structure doc.

set -euo pipefail

if [[ -z "${SLACK_TOKEN:-}" ]]; then
  echo "Error: SLACK_TOKEN environment variable is required." >&2
  echo "" >&2
  echo "Get a token by creating a Slack app at https://api.slack.com/apps" >&2
  echo "with User Token Scopes: channels:manage, groups:write," >&2
  echo "channels:write.topic. Install to your workspace, copy the User" >&2
  echo "OAuth Token, then run:" >&2
  echo "" >&2
  echo "  SLACK_TOKEN=xoxp-your-token bash $(basename "$0")" >&2
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "Error: jq is required but not installed." >&2
  echo "Install with: brew install jq" >&2
  exit 1
fi

API="https://slack.com/api"
CREATED=0
SKIPPED=0
FAILED=0

create_channel() {
  local name="$1"
  local is_private="$2"  # "true" or "false"
  local purpose="$3"
  local topic="$4"

  printf "  %-22s " "#$name"

  # Create channel
  local resp
  resp=$(curl -s -X POST "$API/conversations.create" \
    -H "Authorization: Bearer $SLACK_TOKEN" \
    -H "Content-type: application/json; charset=utf-8" \
    -d "$(jq -nc --arg name "$name" --argjson priv "$is_private" \
          '{name:$name,is_private:$priv}')")

  local ok
  ok=$(echo "$resp" | jq -r '.ok')

  if [[ "$ok" != "true" ]]; then
    local err
    err=$(echo "$resp" | jq -r '.error // "unknown"')
    if [[ "$err" == "name_taken" ]]; then
      echo "(already exists, skipping)"
      SKIPPED=$((SKIPPED + 1))
      return 0
    fi
    echo "FAILED: $err"
    FAILED=$((FAILED + 1))
    return 1
  fi

  local channel_id
  channel_id=$(echo "$resp" | jq -r '.channel.id')

  # Set purpose (longer description, shown in channel details)
  curl -s -X POST "$API/conversations.setPurpose" \
    -H "Authorization: Bearer $SLACK_TOKEN" \
    -H "Content-type: application/json; charset=utf-8" \
    -d "$(jq -nc --arg ch "$channel_id" --arg purpose "$purpose" \
          '{channel:$ch,purpose:$purpose}')" >/dev/null

  # Set topic (short one-liner shown in channel header)
  if [[ -n "$topic" ]]; then
    curl -s -X POST "$API/conversations.setTopic" \
      -H "Authorization: Bearer $SLACK_TOKEN" \
      -H "Content-type: application/json; charset=utf-8" \
      -d "$(jq -nc --arg ch "$channel_id" --arg topic "$topic" \
            '{channel:$ch,topic:$topic}')" >/dev/null
  fi

  echo "created"
  CREATED=$((CREATED + 1))
}

echo "Creating Pyde Slack workspace channels..."
echo ""

# ── General ───────────────────────────────────────────────────────────
echo "General:"
create_channel "announcements" "false" \
  "Team-wide broadcasts: org news, milestones, new hires. Posting restricted to admins; everyone reads." \
  "Read-only broadcast channel"

create_channel "general" "false" \
  "Default channel for day-to-day team conversation. Anything that is not better-served by a more specific channel." \
  ""

create_channel "random" "false" \
  "Off-topic, banter, water-cooler. Anything that does not fit elsewhere." \
  "Off-topic"

# ── Functional ─────────────────────────────────────────────────────────
echo ""
echo "Functional:"
create_channel "engineering" "false" \
  "Protocol design, code review, architecture, technical discussions. Splits into #eng-alpha (toolchain), #eng-beta (execution), #eng-gamma (consensus) when the three teams form per IMPLEMENTATION_PLAN." \
  "Protocol + code"

create_channel "design" "false" \
  "Brand, visual, UX. Reviews, decisions, asset links. Pairs with Figma." \
  "Brand + visual"

create_channel "growth" "false" \
  "Marketing, content, social, community operations. Outbound comms." \
  "Marketing + comms"

create_channel "ops" "false" \
  "Finance, legal, hiring coordination, infra, vendor management." \
  "Ops"

# ── Projects (close when done) ────────────────────────────────────────
echo ""
echo "Projects:"
create_channel "proj-mainnet" "false" \
  "Mainnet preparation: audits, testnet operations, launch coordination. Close when mainnet ships." \
  "Mainnet prep"

create_channel "proj-alliance" "true" \
  "Alliance DAO application work. Private — sensitive narrative, financials, founder strategy." \
  "Alliance DAO"

create_channel "proj-website" "false" \
  "pyde.network + book.pyde.network development. UI/UX, content, deploys." \
  "Website + book"

# ── Alerts (bot output, mute by default) ──────────────────────────────
echo ""
echo "Alerts:"
create_channel "alerts-deploys" "false" \
  "AWS Amplify build notifications across pyde-net repos. Mute by default; on-call reads." \
  "Build alerts"

create_channel "alerts-github" "false" \
  "PR opens, merges, CI status across pyde-net org. Mute by default." \
  "GitHub events"

create_channel "alerts-monitoring" "false" \
  "Validator metrics, uptime, infra alerts. Activates post-testnet." \
  "Infra monitoring"

# ── Private (gated) ───────────────────────────────────────────────────
echo ""
echo "Private:"
create_channel "leadership" "true" \
  "Founder-only. Board prep, sensitive strategic decisions, partnership negotiations." \
  "Founders only"

create_channel "hiring" "true" \
  "Candidate pipeline, offers, hiring discussions. Private to the hiring panel." \
  "Hiring"

create_channel "security" "true" \
  "Vulnerability reports, audit findings, incident response coordination. Restricted to security team." \
  "Security"

echo ""
echo "Done. Created: $CREATED, skipped (already existed): $SKIPPED, failed: $FAILED"
echo ""
echo "Next steps:"
echo "  1. Invite Claude bot to channels where you want it: /invite @Claude"
echo "  2. Set up user groups (@leadership, @engineering, @design, @growth, @ops, @security)"
echo "  3. Group channels into sidebar sections (Slack UI: right-click sidebar -> Create section)"
echo "  4. Delete the bootstrap Slack app at https://api.slack.com/apps"
echo "  5. See .github/SLACK_WORKSPACE.md for the full conventions doc"
