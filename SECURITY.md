# Security Policy

Pyde is a Layer 1 blockchain in pre-mainnet development.
This policy applies to every repo in the
[pyde-net](https://github.com/pyde-net) org unless an individual repo
overrides it with a more specific `SECURITY.md`.

## Reporting a vulnerability

**Do not open a public issue for security vulnerabilities.**

Email: **`security@pyde.network`** *(or until that's live: `info@pyde.network`,
the project contact via README)*

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
- The WASM execution layer (post-pivot, to be re-cut in a fresh engine workspace; the pre-pivot reference is in [`archive`](https://github.com/pyde-net/archive))
- The retired Otigen compiler in [`otic`](https://github.com/pyde-net/otic), a historical artifact, though logic bugs that could resurface post-pivot are still in scope
- Wire-format / consensus / mempool design issues
- Logic bugs in `pyde-book` companion specs that, if implemented as
  documented, would create a vulnerability

Out of scope:

- The pre-pivot codebase in [`archive`](https://github.com/pyde-net/archive)
  (archived, read-only, not part of the active project)
- Third-party dependencies (report those upstream, and we'll happily help
  with disclosure coordination, but the patch belongs there)
- Issues in private/internal infrastructure (CI keys, secrets, etc.);
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
- **Day 14 to 90:** Triage, fix, internal review. We'll keep you updated
- **Disclosure:** Coordinated public disclosure once a patch is released,
  or after 90 days (whichever is sooner), unless we explicitly agree
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
(Phase 9 of the [launch plan](https://book.pyde.network/chapters/19-launch-strategy)).
Pre-mainnet vulnerability reports are not currently compensated
financially but will be credited at the bounty program's launch, with
priority consideration for retroactive recognition.

## What pre-mainnet status means

Pyde is pre-launch. The codebase is being prepared for external audit
across five specialist tracks (consensus, WASM execution layer, cryptography,
networking, otigen toolchain) per
[`pyde-book` Chapter 19](https://book.pyde.network/chapters/19-launch-strategy).
Vulnerabilities found in the pre-audit code are valuable input to the
audit, not a sign the audit has failed. We welcome them.

Specifically, the multi-region performance harness build-out (specified in [`pyde-book` companion/PERFORMANCE_HARNESS.md](https://book.pyde.network/companion/PERFORMANCE_HARNESS)) is the gating prerequisite before benchmark numbers are published, and the work that surfaces it tends to surface vulnerability classes too.

## Cryptographic primitive caveats

One known constraint surfaces here, tracked for post-mainnet
hardening:

- `ml-kem` (Kyber-768, used for transport-layer encryption) is at
  `0.3.0-rc.0` (NIST FIPS 203 release candidate); upgrading to the
  stable release is on the post-mainnet checklist.

Reports against this known constraint are appreciated as confirmation
or expansion of impact, but the constraint itself is not novel.

## License

This security policy is licensed under CC0, so copy and adapt freely.
