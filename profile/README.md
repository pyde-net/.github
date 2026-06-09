<p align="center">
  <img src="../assets/logo.png" width="140" alt="Pyde logo" />
</p>

<h1 align="center">Pyde</h1>

<p align="center">
  <em>Post-quantum · MEV-resistant · Sub-second · Commodity-decentralized</em>
</p>

---

A Layer 1 blockchain built greenfield to ship four properties as
defaults at genesis — none of which any production chain combines
today:

- **Post-quantum cryptography** — FALCON-512 signatures, Kyber-768
  threshold encryption, Poseidon2 + Blake3 hybrid hashing. No
  pre-quantum primitive on any consensus or account path.
- **MEV resistance by structure, not policy** — threshold-encrypted
  mempool + commit-before-reveal ordering. Sandwich attacks,
  front-running, and proposer extraction are not auctioned or
  mitigated — they are structurally impossible.
- **Sub-second finality** — Mysticeti consensus with ~500ms median
  commit, 85-of-128 FALCON quorum certificates.
- **Commodity-hardware decentralization** — full nodes and validators
  awaiting committee selection run on 8c / 16GB. Equal voting power
  within the active committee; single-tier 10,000 PYDE stake
  minimum, uniform-random committee selection per epoch.

The execution layer is **WebAssembly** via wasmtime, with Cranelift
ahead-of-time compilation and a hybrid parallel scheduler combining
static access lists with Block-STM speculation. Smart contracts can
be authored in **Rust, AssemblyScript, Go (TinyGo), or C/C++** —
whatever language fits the team — and bundled by the **`otigen`**
developer toolchain, which handles language detection, build
invocation, state binding generation, and deploy submission.

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
| WASM execution layer (wasmtime + Cranelift) | Functional — macro substrate (`#[pyde::entry]` + typed storage + events) + cross-contract calls + typed-storage host fns all shipped |
| State layer (JMT, hybrid Blake3 + Poseidon2 hashing) | In place; hybrid hashing wired                                                                                                     |
| Devnet binary (`pyde devnet`)            | Shipped — one-command local devnet, 10 prefunded accounts                                                                          |
| Developer toolchain (`otigen`)           | Shipped — scaffold / build / test / deploy / inspect / verify / console / wallet / validator across Rust / TinyGo / AssemblyScript / C |
| Mysticeti consensus                      | Rebuild in progress post-pivot                                                                                                     |
| Threshold cryptography (PQ)              | Research-grade — bleeding-edge                                                                                                     |
| Network protocol                         | Existing; libp2p + QUIC migration in flight                                                                                        |
| Performance harness (multi-region, chain-throughput) | Not yet built (mandatory before any TPS claim)                                                                                     |

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

The private repos cover the engine workspace (execution + consensus +
node binary), the `otigen` developer toolchain (scaffold / build /
test / deploy / inspect / console / wallet / validator), `pyde-crypto`
itself, the Rust + TypeScript SDKs, the block explorer, and the
marketing website. Each will open publicly as the implementation
stabilises and security review allows.

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

- 📧 **Email:** `info@pyde.network`
- 🌐 **Website:** <https://pyde.network>
- 🔐 **Security disclosures:** `security@pyde.network` (see [SECURITY.md](https://github.com/pyde-net/.github/blob/main/SECURITY.md))

(Additional channels will be announced as the project moves from
pre-mainnet engineering toward public testnet.)

---

## License

Code is licensed under Apache-2.0 (per-repo `LICENSE` files).
The book is licensed under CC BY-SA 4.0.

Substantive protocol changes go through a **PIP** (Pyde Improvement
Proposal) — see the `pips` repo once it's published.
