<p align="center">
  <img src="../assets/logo.png" width="140" alt="Pyde logo" />
</p>

<h1 align="center">Pyde</h1>

<p align="center">
  <strong>The blockchain, finally</strong>
</p>

<p align="center">
  <em>Quantum-safe · front-run-proof · built to last</em>
</p>

---

Pyde is a quiet attempt at what blockchain networks should have been
— built around four properties that should already be standard, and
that no production chain combines today.

**Cryptography that won't break when quantum computing arrives.**
Post-quantum from the first block. No emergency hard-fork when the
math the rest of crypto relies on stops being safe.

**Transactions nobody — not even the chain — can read until they're
committed.** Front-running isn't policed or auctioned here. It can't
happen.

**Sub-second finality.** Your trade is final when the chain says it's
final, and the chain says so in about half a second.

**A validator can run on a laptop.** No data-center rigs. Equal
voting power inside the active committee. No quiet centralization.

Smart contracts run on WebAssembly — write them in **Rust,
AssemblyScript, Go (TinyGo), or C/C++**, and ship with one tool:
**`otigen`**.

The work is intentional, slow, and documented end-to-end before it
ships.

---

## Honest status

Pyde is **pre-mainnet**. Architecture design is complete. The protocol
has gone through two clean pivots, both honest, both for the right
reasons:

- **Consensus pivot** — from an in-house HotStuff variant (whose
  persistent wedges and stalls at 400ms slot timing motivated a clean
  rebuild) to Mysticeti-style DAG consensus.
- **Execution pivot** — from a custom virtual machine and a
  domain-specific language (Otigen) to WebAssembly via wasmtime. The
  Otigen name lives on as the developer toolchain. The full story is
  in [pyde-book/src/preface/pivot.md](https://book.pyde.network/preface/pivot).

| Component                                | State                                                                                                                              |
| ---------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| Architecture design                      | Complete                                                                                                                           |
| WASM execution (wasmtime + Cranelift AOT, Block-STM) | Live — pooled engine, Host Function ABI v1.0 frozen, Block-STM wired into the commit walk                                          |
| State (JMT + hybrid Blake3 / Poseidon2 dual root) | Wired end-to-end — `StateRoot { blake3, poseidon2 }` everywhere it matters                                                      |
| Devnet binary (`pyde devnet`)            | Shipped — one-command local devnet, 10 prefunded accounts                                                                          |
| Developer toolchain (`otigen`)           | Shipped — scaffold / build / test / deploy / inspect / verify / console / wallet / validator across Rust / TinyGo / AssemblyScript / C |
| Mysticeti DAG consensus                  | In progress — vertex / anchor / beacon / committee / wave commit live; multi-validator genesis DKG + state-sync replay shipped; soak-hardening + resharing edge cases in flight |
| Threshold cryptography (Kyber-768 + PSS-refresh) | In progress — DKG + per-epoch resharing + live hot-swap shipped; encrypted-tx survival across rotation still tracked as an open bug |
| Network protocol (libp2p + QUIC + Gossipsub) | Migrated — layered discovery, peer scoring, sentry-friendly topology                                                            |
| Performance harness (multi-region, chain-throughput) | In progress — local soak driver + multi-validator cluster CLI live; multi-region rig + chaos scenarios not yet built          |
| SDKs (TypeScript + Rust)                 | In progress — `pyde-ts-sdk` 0.1.0 staged; Rust SDK in build                                                                       |

Mainnet ships when the implementation is complete, audited, and
validated by an incentivized testnet. **No public schedule.** No
external TPS claim without harness evidence — publish only what the
harness measures, never lab extrapolations.

---

## Read

The comprehensive technical reference is the **Pyde Book** — read it
at **[book.pyde.network](https://book.pyde.network)** (source lives at
[`pyde-net/pyde-book`](https://github.com/pyde-net/pyde-book)):

- 📘 **[Pyde Book](https://book.pyde.network)** — full architecture:
  20 chapters covering the VM, state model, consensus, cryptography,
  MEV protection, gas/fee model, account model, networking,
  governance, security, and the phased launch plan.
  Includes companion specs for the threat model, slashing, validator
  lifecycle, state sync, chain halt + recovery, and the performance
  harness.

Most repositories in the [pyde-net](https://github.com/pyde-net) org
are **private during pre-mainnet engineering** — access on request
([info@pyde.network](mailto:info@pyde.network)). Public today:

- [`pyde-book`](https://github.com/pyde-net/pyde-book) — the canonical
  technical reference (rendered at [book.pyde.network](https://book.pyde.network)).
- [`pips`](https://github.com/pyde-net/pips) — the Pyde Improvement
  Proposal registry.
- [`pyde-crypto-wasm`](https://github.com/pyde-net/pyde-crypto-wasm) —
  WebAssembly bindings to the post-quantum primitives for in-browser
  signing.
- [`test-releases`](https://github.com/pyde-net/test-releases) —
  signed binary mirror for `otigen` (the install script resolves
  against this) with sigstore (cosign) provenance on every release.

The private repos cover the engine workspace (execution + consensus +
node binary), the `otigen` developer toolchain (scaffold / build /
test / deploy / inspect / console / wallet / validator), `pyde-crypto`
itself, the Rust + TypeScript SDKs, the block explorer, the testnet
faucet, and the marketing website. Each will open publicly as the
implementation stabilises and security review allows.

The pre-pivot `otic` compiler, `wright` toolchain, and the original
Otigen language book are preserved as historical artifacts in the
[`archive`](https://github.com/pyde-net/archive) repo and in their
own retired-status repos.

---

## Who's building this

Pyde is built by **zarah**, making the technical choices and shipping
the work. The consensus pivot from HotStuff to Mysticeti DAG and the
execution pivot from a custom VM to WebAssembly both reflect an
explicit preference for designing from a clean foundation over
patching accumulated technical debt — and for killing darlings
honestly when the evidence says they should be killed.

Engineering rigor is the project's discipline. Every claim in the
book is grounded in either code that's running or an explicit "this
is the designed behavior; the code is in flight." Performance
numbers come from the harness — never from microbenchmarks or
local devnet measurements, never lab extrapolations.

This is not vaporware. It is also not yet a shipped chain. The
distinction matters.

---

## Community

- 📜 [**Contributing**](https://github.com/pyde-net/.github/blob/main/CONTRIBUTING.md) — how to propose changes, PIP process, engineering standards
- 🔒 [**Security policy**](https://github.com/pyde-net/.github/blob/main/SECURITY.md) — vulnerability disclosure, scope, safe harbor
- 🤝 [**Code of Conduct**](https://github.com/pyde-net/.github/blob/main/CODE_OF_CONDUCT.md) — community standards (Contributor Covenant 2.1)
- 📋 [**Pyde Improvement Proposals (PIPs)**](https://github.com/pyde-net/pips) — protocol-affecting changes go here

These apply org-wide. Individual repos may publish more specific
versions where the domain warrants it (e.g., a crate-specific security
policy on `pyde-crypto` once the audit kicks off).

---

## Contact

- **Website:** <https://pyde.network>
- **Book:** <https://book.pyde.network>
- **Email:** `info@pyde.network`
- **X:** [`@pydenet`](https://x.com/pydenet)
- **Telegram:** [`t.me/pydenet`](https://t.me/pydenet)
- **Security disclosures:** `security@pyde.network` (see [SECURITY.md](https://github.com/pyde-net/.github/blob/main/SECURITY.md))

---

## License

Code is licensed under Apache-2.0 (per-repo `LICENSE` files).
The book is licensed under CC BY-SA 4.0.

Substantive protocol changes go through a **PIP** (Pyde Improvement
Proposal) — see the [`pips`](https://github.com/pyde-net/pips) repo.
