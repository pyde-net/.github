<p align="center">
  <img src="../assets/logo.png" width="140" alt="Pyde logo" />
</p>

<h1 align="center">Pyde</h1>

<p align="center">
  <em>Post-quantum · MEV-free · Sub-second · Commodity-decentralized</em>
</p>

---

A Layer 1 blockchain built greenfield to ship four properties as
defaults at genesis — none of which any production chain combines
today:

- **Post-quantum cryptography** — FALCON-512 signatures, Kyber-768
  threshold encryption, Poseidon2 + Blake3 hybrid hashing. No
  pre-quantum primitive on any consensus or account path.
- **MEV resistance by structure, not policy** — threshold-encrypted
  mempool + commit-before-reveal ordering + DAG consensus. Sandwich
  attacks, front-running, and proposer extraction are not auctioned
  or mitigated — they are structurally impossible.
- **Sub-second finality** — Mysticeti-style DAG consensus with
  ~500ms median commit, 85-of-128 FALCON quorum certificates.
- **Commodity-hardware decentralization** — full nodes and validators
  awaiting committee selection run on 8c / 16GB. Equal voting power
  within the active committee; single-tier 10,000 PYDE stake
  minimum, uniform-random committee selection per epoch.

The execution layer is a register-based virtual machine (PVM) with a
hybrid parallel scheduler combining static access lists with
Block-STM speculation. Smart contracts are written in **Otigen**, a
purpose-built language with reentrancy guards, checked arithmetic,
and compile-time access-list inference.

---

## Honest status

Pyde is **pre-mainnet**. The architecture design is complete; the
execution layer and cryptography crates are functional; the
consensus layer is being rebuilt design-first following a **May 2026
pivot** from an in-house HotStuff variant (whose persistent wedges
and stalls at 400ms slot timing motivated a clean rebuild) to
Mysticeti-style DAG consensus.

| Component                         | State                                          |
| --------------------------------- | ---------------------------------------------- |
| Architecture design               | Complete                                       |
| PVM + Otigen execution            | Functional, extensions in flight               |
| State layer (JMT, hybrid hashing) | In place, hybrid hashing wiring in flight      |
| Mysticeti DAG consensus           | Rebuild in progress post-pivot                 |
| Threshold cryptography (PQ)       | Research-grade — bleeding-edge                 |
| Network protocol                  | Existing; libp2p + QUIC migration in flight    |
| Performance harness               | Not yet built (mandatory before any TPS claim) |

Mainnet ships when the implementation is complete, audited (five
specialist external audits), and validated by an incentivized
testnet. **No public schedule.** No external TPS claim without
harness evidence — the "claim 1/3 of measured peak" discipline.

---

## Read

The comprehensive technical reference is the **Pyde Book**:

- 📘 **[pyde-book](https://github.com/pyde-net/pyde-book)** — full
  architecture: 20 chapters covering the VM, state model, consensus,
  cryptography, MEV protection, gas/fee model, account model,
  networking, governance, security, and the phased launch plan.
  Includes companion specs for the threat model, slashing, validator
  lifecycle, state sync, chain halt + recovery, and the performance
  harness.

More repositories will go public as the implementation stabilizes —
the language reference (Otigen book), the execution-layer engine
workspace, the otic compiler, the developer toolchain (pyde-dev),
the Rust and WASM SDKs, the block explorer, and the PIP (Pyde
Improvement Proposal) registry.

---

## Who's building this

Pyde is built by **zarah**, a solo founder making the technical
choices and shipping the work. The May 2026 pivot from HotStuff to
Mysticeti DAG consensus reflects an explicit preference for designing
from a clean foundation over patching accumulated technical debt.

Engineering rigor is the project's discipline. Every claim in the
book is grounded in either code that's running or an explicit "this
is the designed behavior; the code is in flight." Performance
numbers come from the harness — never from microbenchmarks or
local devnet measurements — under the "claim 1/3 of measured peak"
rule.

This is not vaporware. It is also not yet a shipped chain. The
distinction matters.

---

## Contact

- 📧 **Email:** `info@pyde.network`
- 🌐 **Website:** <https://pyde.network>

(Additional channels will be announced as the project moves from
pre-mainnet engineering toward public testnet.)

---

## License

Code is licensed under Apache-2.0 (per-repo `LICENSE` files).
The book is licensed under CC BY-SA 4.0.

Substantive protocol changes go through a **PIP** (Pyde Improvement
Proposal) — see the `pips` repo once it's published.
