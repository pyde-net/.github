<p align="center">
  <img src="../assets/logo.png" width="140" alt="Pyde logo" />
</p>

<h1 align="center">Pyde</h1>

<p align="center">
  <strong>The blockchain, finally.</strong>
</p>

<p align="center">
  <em>Fair by default · anyone can run it · built to last</em>
</p>

---

Pyde is a quiet attempt at what a blockchain could have been from the start. Not a faster copy of what already exists, but a base layer built around a handful of properties that should already be standard, and that no production chain combines today.

**Trades that can't be front-run.** On most chains, bots quietly tax ordinary users by reordering their trades. On Pyde, a transaction's place in line is locked before anyone, including the network itself, can see what it contains. There is no committee key to trust and no relayer to opt into, so front-running has nothing to act on. Users keep the price they signed.

**One network, not another island.** Every new chain splits liquidity and users a little further, and the bridges meant to reconnect them keep getting drained. Pyde is built to reach the rest of the world through its own security, not a bridge you have to trust. A Pyde transaction is verifiable by anyone today, and the parachain layer that connects it to other chains and to real-world data is the chapter we are building next.

**A network anyone can run.** A validator runs on an ordinary laptop, not a data center rig, and every seat on the committee carries one vote regardless of stake. No quiet centralization.

**Fast, and built to last.** Your transaction is final when the chain says it is, and it says so in about half a second. The cryptography protecting it is chosen to stay valid for decades, long after today's computers can no longer keep it safe.

Contracts run on WebAssembly, so teams build in languages they already know (Rust, Go, C, and AssemblyScript) and ship with a single tool, `otigen`. The work is deliberate, and documented end to end before it ships.

---

## Where it stands

We would rather be plain about status than polished about it. Pyde is pre-mainnet. The architecture is designed, and the hard parts are built: the execution engine runs, the state layer is wired end to end, the developer toolchain and a one-command local devnet are shipped, and the native token standard works from start to finish. Consensus is live and being hardened under sustained, adversarial conditions.

What remains is the careful part. Proving the network holds up under real load, completing external security audits, and standing up the public infrastructure that lets anyone join. Mainnet ships when the work is complete, audited, and validated by an incentivized testnet. There is no public schedule, and we publish performance numbers only after a real multi-region harness has measured them, never lab estimates.

---

## Explore

- **[The Pyde Book](https://book.pyde.network)** is the full story and the complete technical reference, from how the chain works to how it launches. Source lives at [`pyde-book`](https://github.com/pyde-net/pyde-book).
- **[Pyde Improvement Proposals](https://github.com/pyde-net/pips)** are where the protocol grows, one proposal at a time.

Open source today: the book, the improvement proposals, the cryptography ([`pyde-crypto`](https://github.com/pyde-net/pyde-crypto) and its [browser build](https://github.com/pyde-net/pyde-crypto-wasm)), the contract interface ([`pyde-host`](https://github.com/pyde-net/pyde-host)), the [Rust](https://github.com/pyde-net/pyde-rust-sdk) and [TypeScript](https://github.com/pyde-net/pyde-ts-sdk) SDKs, the [contract templates](https://github.com/pyde-net/otigen-templates), and the signed [toolchain releases](https://github.com/pyde-net/test-releases).

The engine, the `otigen` toolchain, the in-browser playground, the explorer, the faucet, and the website stay private during pre-mainnet engineering, and open as each stabilizes and security review allows. Access on request at [info@pyde.network](mailto:info@pyde.network).

---

## Community

- [**Contributing**](https://github.com/pyde-net/.github/blob/main/CONTRIBUTING.md), how to propose changes, the PIP process, and engineering standards.
- [**Security policy**](https://github.com/pyde-net/.github/blob/main/SECURITY.md), vulnerability disclosure, scope, and safe harbor.
- [**Code of Conduct**](https://github.com/pyde-net/.github/blob/main/CODE_OF_CONDUCT.md), our community standards (Contributor Covenant 2.1).

These apply across the org. Substantive protocol changes go through a Pyde Improvement Proposal in the [`pips`](https://github.com/pyde-net/pips) repo.

---

## Contact

- **Website:** <https://pyde.network>
- **Book:** <https://book.pyde.network>
- **Email:** `info@pyde.network`
- **X:** [`@pydenet`](https://x.com/pydenet)
- **Telegram:** [`t.me/pydenet`](https://t.me/pydenet)
- **Security disclosures:** `security@pyde.network`

---

## License

Code is licensed under Apache-2.0 (per-repo `LICENSE` files). The book is licensed under CC BY-SA 4.0.
