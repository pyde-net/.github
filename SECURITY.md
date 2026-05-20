# Security Policy

Pyde is a post-quantum Layer 1 blockchain in pre-mainnet development.
This policy applies to every repo in the
[pyde-net](https://github.com/pyde-net) org unless an individual repo
overrides it with a more specific `SECURITY.md`.

## Reporting a vulnerability

**Do not open a public issue for security vulnerabilities.**

Email: **`security@pyde.network`** *(or until that's live: `<email>`
— project contact via README)*

Please include:

- A description of the vulnerability
- Steps to reproduce (or a proof-of-concept if you have one)
- Which repo / commit / module is affected
- Your assessment of the severity and impact
- Whether the issue is exploitable in the current code or only after a
  hypothetical future change

We will respond within **5 business days** acknowledging receipt. A
full triage decision typically follows within 14 days.

## Scope

In scope:

- All public code in `pyde-net` org repos
- Cryptographic implementations in [`pyde-crypto`](https://github.com/pyde-net/pyde-crypto)
- The PVM + AOT compiler in [`engine`](https://github.com/pyde-net/engine)
- The Otigen compiler in [`otic`](https://github.com/pyde-net/otic)
- Wire-format / consensus / mempool design issues
- Logic bugs in `pyde-book` companion specs that, if implemented as
  documented, would create a vulnerability

Out of scope:

- The pre-pivot codebase in [`archive`](https://github.com/pyde-net/archive)
  (archived, read-only, not part of the active project)
- Third-party dependencies (report those upstream — we'll happily help
  with disclosure coordination, but the patch belongs there)
- Issues in private/internal infrastructure (CI keys, secrets, etc.) —
  report directly via email regardless of "scope"
- Social-engineering issues unrelated to protocol design
- Issues that require a compromised wallet, browser, or operator
  endpoint (i.e., classes that any chain has)

## Severity classification

We use a standard four-level scale:

| Severity | Examples |
|---|---|
| **Critical** | Funds theft, consensus break, double-spend, key extraction, signature forgery |
| **High** | DoS that halts the chain or a validator, privilege escalation, MEV reintroduction |
| **Medium** | Significant correctness bugs without funds-loss path, partial DoS |
| **Low** | Edge-case correctness issues, hardening gaps, documentation issues with security implications |

## Disclosure timeline

Standard responsible-disclosure with reasonable flexibility:

- **Day 0:** Report received, acknowledged within 5 business days
- **Day 14–90:** Triage, fix, internal review. We'll keep you updated
- **Disclosure:** Coordinated public disclosure once a patch is released,
  or after 90 days (whichever is sooner) — unless we explicitly agree
  on an extended embargo for serious issues

We will credit you in the disclosure unless you prefer anonymity.

## Safe harbor

We will not pursue legal action against good-faith security research
that:

- Complies with this policy
- Avoids privacy violations, destruction of data, or service
  interruption
- Reports findings promptly via the channel above
- Does not exploit a finding beyond what's needed to demonstrate it

## Bug bounty

A formal bug bounty program will launch with the incentivized testnet
(Phase 9 of the [launch plan](https://github.com/pyde-net/pyde-book/blob/main/src/chapters/19-launch-strategy.md)).
Pre-mainnet vulnerability reports are not currently compensated
financially but will be credited at the bounty program's launch, with
priority consideration for retroactive recognition.

## What pre-mainnet status means

Pyde is pre-launch. The codebase is being prepared for external audit
across five specialist tracks (consensus, PVM/execution, cryptography,
networking, otic compiler) per
[`pyde-book` Chapter 19](https://github.com/pyde-net/pyde-book/blob/main/src/chapters/19-launch-strategy.md).
Vulnerabilities found in the pre-audit code are valuable input to the
audit, not a sign the audit has failed. We welcome them.

Specifically, the
[`engine/BENCHMARK_PLAN.md`](https://github.com/pyde-net/engine/blob/main/BENCHMARK_PLAN.md)
hardening sweep is the gating prerequisite before benchmark numbers
are published — that work surfaces classes of issues you might find.

## Cryptographic primitive caveats

Two known constraints surface here, both tracked for post-mainnet
hardening:

- `ml-kem` is at `0.3.0-rc.0` (NIST FIPS 203 release candidate);
  upgrading to the stable release is on the post-mainnet checklist.
- PSS resharing in `pyde-crypto::threshold` verifies polynomial
  consistency but does **not** detect constant-term substitution.
  Pedersen / KZG commitments on resharing shares are post-mainnet
  hardening (see `pyde-book` Chapter 8 §8.6).

Reports against these known constraints are appreciated as confirmation
or expansion of impact, but the constraints themselves are not novel.

## License

This security policy is licensed under CC0 — copy + adapt freely.
