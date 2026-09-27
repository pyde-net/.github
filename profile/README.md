<p align="center">
  <img src="../assets/logo.png" width="140" alt="Pyde logo" />
</p>

<h1 align="center">Pyde</h1>

<p align="center">
  <strong>Infrastructure for Global Economic State</strong>
</p>

<p align="center">
  <em>Distributed ledger infrastructure for a connected global economy</em>
</p>

Pyde is distributed ledger technology for a connected global economy. It provides a common programmable foundation for representing and coordinating economic state across sovereign economic networks, open settlement infrastructure, and a permissionless public network.

The core abstraction is **global economic state**. It is broader than tokenized assets. It includes balances, ownership, authorization, identity references, obligations, licenses, settlement positions, regulatory status, and the rules that govern how those states change.

## The three economic environments

### Tier 1 — Sovereign Consortium Network

A sovereign economic domain operates as a permissioned network whose validators are designated sovereign institutions such as central banks, finance ministries, and tax authorities.

The network can represent a native sovereign digital currency and state controlled economic rules including KYC status, minting, burning, freezing, seizure, and institutional authorization. Identity remains outside the ledger; the protocol stores the references and state needed to enforce the jurisdiction's rules.

Licensed institutions participate through approved contracts and service accounts. They do not become sovereign validators simply by participating in the economic system.

### Tier 2 — Open Interlinking Settlement

Tier 2 connects sovereign economic domains with one another and with the public network without becoming a central bank or a pool of sovereign money.

Anyone can operate a Tier 2 validator by participating in its staking and consensus system. Validators coordinate obligations and positions, publish aggregated foreign exchange observations, and reach quorum before state transitions that affect settlement coordination are accepted.

Sovereign currencies remain inside their respective settlement pools. Tier 2 coordinates rights over those pools, executes cross domain settlement logic, and supports bilateral and multilateral netting so that only residual obligations require final settlement.

### Tier 3 — Permissionless Public Network

Tier 3 is the open environment for developers, users, and applications.

Anyone can deploy contracts and interact with public state subject to the network's protocol rules. The same underlying DLT foundation supports this environment while its execution surface and authority model remain distinct from sovereign and interlinking networks.

## One DLT foundation

The three tiers share a common distributed ledger foundation while exposing different capabilities.

The execution architecture uses Wasmtime with profile specific capabilities selected at compile time. A capability that does not belong in a sovereign execution profile is structurally absent from that binary rather than merely hidden behind a runtime permission flag.

The state layer commits economic state cryptographically, and the execution model supports parallel transaction processing with deterministic validation. Cryptographic components include post quantum signatures such as FALCON-512, alongside the protocol's state and consensus mechanisms.

This lets Pyde preserve a common DLT foundation without forcing sovereign, settlement, and permissionless environments into one authority model.

## Where Pyde fits

The architecture is designed around a simple boundary:

**Sovereign networks own sovereign economic authority.  
Tier 2 coordinates cross domain obligations and settlement.  
Tier 3 provides permissionless public infrastructure.**

Pyde does not require every participant to trust the same institution. Authority remains explicit at each layer, while the protocol provides the shared state model and settlement machinery needed for the systems to interact.

The current public development environment is Tier 3. The broader architecture defines how sovereign and open settlement environments use the same DLT foundation while retaining their distinct authority and operating models.

## Explore

- **[Website](https://pyde.network)** — the architecture and the product overview.
- **[Whitepaper](https://pyde.network/whitepaper.pdf)** — the full architectural and economic model.
- **[Pyde Improvement Proposals](https://github.com/pyde-net/pips)** — the process for protocol level changes.
- **[Technical Book](https://book.pyde.network)** — deeper protocol and implementation material.

## Community

- **[Contributing](https://github.com/pyde-net/.github/blob/main/CONTRIBUTING.md)** — contribution standards and the protocol change process.
- **[Security policy](https://github.com/pyde-net/.github/blob/main/SECURITY.md)** — vulnerability disclosure, scope, and safe harbor.
- **[Code of Conduct](https://github.com/pyde-net/.github/blob/main/CODE_OF_CONDUCT.md)** — community standards.

## Contact

- **Website:** <https://pyde.network>
- **Email:** `info@pyde.network`
- **X:** [@pydenet](https://x.com/pydenet)
- **Telegram:** [t.me/pydenet](https://t.me/pydenet)
- **Security disclosures:** `security@pyde.network`

## License

Follow the license published in each repository. Repository specific terms take precedence over this organization profile.
