# Contributing to Pyde

Thanks for thinking about contributing. Pyde is a post-quantum Layer 1
in active pre-mainnet development. The repos in the
[pyde-net](https://github.com/pyde-net) org share this contribution
process unless an individual repo overrides it.

## The two paths

There are two ways to contribute, depending on what you're changing.

### Path A — Protocol-affecting changes (require a PIP)

If your change affects:

- Consensus rules
- Transaction types or wire formats
- Gas costs or fee distribution
- Cryptographic primitives
- State layout or commitment scheme
- The WASM host function ABI
- Validator / staking / slashing logic

…then it's a **protocol change** and requires a **PIP (Pyde Improvement
Proposal)** before any implementation lands. See the
[pips](https://github.com/pyde-net/pips) repo for the process, and
[PIP-0001](https://github.com/pyde-net/pips/blob/main/pip-0001-pip-purpose.md)
for the system overview.

The short version:

1. Open a PR against `pyde-net/pips` adding `pip-NNNN-short-title.md`
2. Iterate through Draft → Review → Last Call → Accepted (or Rejected)
3. After acceptance, the reference implementation PR lands in the
   relevant repo (`engine`, `otigen`, `pyde-crypto`, etc.) referencing
   the PIP number
4. Validators upgrade voluntarily at the activation slot

### Path B — Non-protocol changes (regular PR)

Bug fixes, clippy cleanup, test additions, documentation improvements,
build / CI tweaks, new examples — these don't need a PIP. Just open a
PR against the relevant repo.

## Engineering standards

The bar for code merged into a `main` branch:

- **`cargo build`** clean
- **`cargo test`** passing
- **`cargo clippy --workspace -- -D warnings`** passing
- **`cargo fmt`** applied
- New code has tests where the change is non-trivial
- No new `unsafe` blocks without a documented invariant comment
  explaining why and what it relies on
- No new `unwrap()` / `expect()` on untrusted-input paths (validate +
  return a typed error instead)

For changes that touch `pyde-crypto`, `engine/crates/aot`, or any
security-relevant code path, expect a more careful review and possibly
external audit gating before mainnet inclusion.

## Commit messages

We use a light convention loosely based on Conventional Commits:

```
<type>(<scope>): <subject>

<body — what + why, not how>
```

Common types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`,
`perf`, `style`, `ci`. Scope is the module or area, e.g. `feat(crypto):`,
`fix(pvm):`, `docs(book):`.

**Do not include any AI / LLM attribution** (no `Co-Authored-By` for
Claude / GPT / etc.) on commits or PRs. The work reads as the
contributor's own.

## PR review

- One reviewer is enough for non-protocol changes
- Protocol changes require PIP acceptance + at least one core-team
  reviewer
- For security-sensitive code (crypto, consensus, AOT), reviewer must
  explicitly LGTM the security implications

## Repository structure

The pyde-net org is a polyrepo. Active repos:

| Repo | Purpose |
|---|---|
| [`pyde-book`](https://github.com/pyde-net/pyde-book) | Technical reference |
| [`engine`](https://github.com/pyde-net/engine) | Execution layer (WASM via wasmtime), state, accounts, transactions, consensus |
| [`pyde-crypto`](https://github.com/pyde-net/pyde-crypto) | Post-quantum cryptography crate |
| [`otic`](https://github.com/pyde-net/otic) | Archived (pre-WASM-pivot): was the Otigen-language compiler |
| [`wright`](https://github.com/pyde-net/wright) | Archived (pre-WASM-pivot): was the pre-WASM-pivot developer toolchain. New WASM-era dev toolchain is `otigen` (separate repo, in development) |
| [`pyde-rust-sdk`](https://github.com/pyde-net/pyde-rust-sdk) | Rust client SDK |
| [`pyde-ts-sdk`](https://github.com/pyde-net/pyde-ts-sdk) | TypeScript client SDK |
| [`crypto-wasm`](https://github.com/pyde-net/crypto-wasm) | WASM bindings for `pyde-crypto` |
| [`otigen-book`](https://github.com/pyde-net/otigen-book) | Historical artifact: original Otigen language reference |
| [`pips`](https://github.com/pyde-net/pips) | Pyde Improvement Proposals |
| [`explorer`](https://github.com/pyde-net/explorer) | Block explorer |
| [`website`](https://github.com/pyde-net/website) | Marketing site (pyde.network) |
| [`archive`](https://github.com/pyde-net/archive) | Pre-pivot codebase (archived, read-only) |

Most are private during pre-mainnet engineering — access on request.

## Communication

- Substantive design discussion: open an issue on the relevant repo
- PIP discussion: PR threads on `pyde-net/pips`
- Security disclosures: see [`SECURITY.md`](./SECURITY.md)

## Code of Conduct

This project follows the [Contributor Covenant](./CODE_OF_CONDUCT.md).
By participating you agree to its terms.

## License

Pyde code is Apache-2.0; the book is CC BY-SA 4.0. By contributing,
you agree your contribution is licensed under the same terms as the
repository you're contributing to.
