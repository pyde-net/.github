# Pyde Slack workspace

This document defines the canonical structure of Pyde Network's Slack workspace — channels, naming conventions, when to add a new channel, and how teams map onto user groups. The intent is that anyone joining can read this and understand where conversations belong without asking.

The structure is bootstrapped by [`scripts/create-slack-channels.sh`](scripts/create-slack-channels.sh) — run that once to create every channel listed below with the right name, purpose, and topic.

---

## Operating principles

1. **Minimal first, grow on demand.** Sixteen channels covers the founding shape; new channels are added only when a recurring conversation outgrows an existing one.
2. **One canonical channel per topic.** If two channels are about the same thing, merge.
3. **Prefixes group related channels visually in the sidebar.** `#alerts-*`, `#proj-*`, `#ext-*`. Permanent functional channels (`#engineering`, `#design`) don't get a prefix.
4. **Close projects when done.** `#proj-*` channels are time-boxed; archive them when the project ships.
5. **Naming:** all lowercase, hyphens for multi-word, no emoji in channel names. Match the brand voice (direct, no fluff).

---

## Channel structure

### General (everyone reads)

| Channel | Privacy | Purpose |
|---|---|---|
| `#announcements` | public, admin-only posting | Team-wide broadcasts: org news, milestones, hires. |
| `#general` | public | Default channel for day-to-day conversation. |
| `#random` | public | Off-topic, banter, water-cooler. |

### Functional (one per discipline — splits when teams grow)

| Channel | Privacy | Purpose |
|---|---|---|
| `#engineering` | public | Protocol design, code review, architecture. Splits into `#eng-alpha` (toolchain), `#eng-beta` (execution), `#eng-gamma` (consensus) when the three implementation streams have dedicated teams. |
| `#design` | public | Brand, visual, UX. Pairs with Figma. |
| `#growth` | public | Marketing, content, social, community ops. |
| `#ops` | public | Finance, legal, hiring, infra, vendors. |

### Projects (time-boxed — `#proj-*`)

| Channel | Privacy | Purpose |
|---|---|---|
| `#proj-mainnet` | public | Mainnet preparation: audits, testnet ops, launch coordination. Close when mainnet ships. |
| `#proj-alliance` | private | Alliance DAO application work. Sensitive narrative + financials. |
| `#proj-website` | public | pyde.network + book.pyde.network development. |

Add new `#proj-*` channels per major initiative; archive when complete.

### Alerts (bot output — mute by default)

| Channel | Privacy | Purpose |
|---|---|---|
| `#alerts-deploys` | public | AWS Amplify build notifications. |
| `#alerts-github` | public | PR opens, merges, CI status across pyde-net org. |
| `#alerts-monitoring` | public | Validator metrics, uptime, infra. Activates post-testnet. |

Configure bot webhooks to post here. Members mute by default; the on-call rotation reads actively.

### External (`#ext-*` — one per active partnership)

These are created on demand, not bootstrapped by the script. Examples:

- `#ext-alliance` — when accepted into the Alliance cohort, for the shared workspace with their team.
- `#ext-auditors` — when audit engagements start.
- `#ext-{partner-name}` — per ecosystem partner.

Privacy: usually private (shared external channels in Slack are private by default).

### Private (gated)

| Channel | Privacy | Who |
|---|---|---|
| `#leadership` | private | Founder(s) + heads. Board prep, strategic decisions. |
| `#hiring` | private | Hiring panel only. Candidates, offers. |
| `#security` | private | Security team only. Vuln reports, audit findings, incident response. |

---

## User groups (`@team-name`)

User groups let you `@mention` a whole team at once. Pyde's groups mirror the functional channels:

| Group | Members |
|---|---|
| `@leadership` | Founder(s), heads of function. |
| `@engineering` | All engineers. Splits into `@eng-alpha`, `@eng-beta`, `@eng-gamma` when the three implementation streams form per [IMPLEMENTATION_PLAN](https://github.com/pyde-net/pyde-book/blob/main/src/companion/IMPLEMENTATION_PLAN.md). |
| `@design` | All designers. |
| `@growth` | Marketing + community. |
| `@ops` | Finance + legal + hiring + IT. |
| `@security` | Security team. Subset of engineering. |

Create user groups in Slack UI → People & user groups → New group. The handle is the `@` mention; the channels listed are the default channels new members get auto-added to.

---

## Sidebar sections

In each member's Slack UI, channels should group under sidebar sections for visual scanning. Each person creates their own sections (Slack stores them per-user), but the canonical groupings are:

```
▸ General        (announcements, general, random)
▸ Functional     (engineering, design, growth, ops)
▸ Projects       (proj-mainnet, proj-alliance, proj-website)
▸ Alerts (mute)  (alerts-deploys, alerts-github, alerts-monitoring)
▸ External       (ext-*)
▸ Private        (leadership, hiring, security)
```

---

## Claude for Slack

Claude is installed at the workspace level (you `@Claude` in any channel where the bot is invited). It's a chat bot — it can read messages in channels it's in, summarize, draft, answer questions. It cannot create channels, manage users, or modify workspace structure.

**Per-user authentication:** each user connects their own Claude account on first use. Their usage counts against their own Claude plan; the workspace admin is not billed for others' usage. Without a connected Claude account, the bot prompts the user to authenticate before responding.

**Where to invite Claude:**

- `#growth` — drafting tweets, copy, content
- `#engineering` — rubber-ducking design questions, summarizing long threads
- `#proj-*` channels — project-specific synthesis
- DMs — private research, writing, summarization

**Where to NOT invite Claude:**

- `#security` — sensitive vuln reports should not leave the channel
- `#hiring` — candidate info should not leave the channel
- `#leadership` — strategic discussions stay internal

Slack's per-channel invite model gives you exact control. Inviting Claude is always explicit; the bot never reads channels it has not been invited to.

---

## Adding a new channel

Before creating a new channel, check:

1. Does an existing channel already cover this? → Use that.
2. Is this a recurring conversation (weekly+)? → Channel is justified.
3. Is this a one-off discussion? → Use a thread in an existing channel.
4. Is this time-boxed (project, drill, audit)? → `#proj-{name}` and archive when done.
5. Is the audience well-defined and small? → Consider private; use the gated examples above as a model.

When you create a channel:

- Set both the **purpose** (longer description) and **topic** (short one-liner).
- Add the right people; pin a short "what this channel is for" message if it's not obvious.
- If it's a permanent functional channel, update this document.

---

## Re-bootstrapping (if the workspace is ever rebuilt)

The script at [`scripts/create-slack-channels.sh`](scripts/create-slack-channels.sh) is idempotent — channels that already exist are skipped, not failed. To re-create the structure (or to bring a new workspace to canonical state):

```bash
# 1. Create a one-shot Slack app at api.slack.com/apps with User
#    Token Scopes: channels:manage, groups:write, channels:write.topic
# 2. Install to workspace, copy User OAuth Token
SLACK_TOKEN=xoxp-... bash .github/scripts/create-slack-channels.sh
# 3. Delete the bootstrap app
```

See the script header for the full prerequisites.
