# Contributing to Pyde

Thanks for thinking about contributing. Pyde is infrastructure for global economic state, organized into three economic environments: Tier 1 sovereign consortium networks, Tier 2 open interlinking settlement infrastructure, and Tier 3 a permissionless public network.

The repositories in the pyde-net organization share this contribution process unless an individual repository defines a more specific policy.

## Protocol and non protocol changes

A change is protocol affecting when it can alter shared state, consensus, execution semantics, authority boundaries, or economic coordination. Examples include consensus and finality rules, transaction formats, state transitions, execution environments, host functions, contract interfaces, cryptographic primitives, account and authorization state, cross domain settlement, FX data aggregation, obligations, positions, netting, validator rules, staking, fee distribution, and tier specific capability boundaries.

Protocol changes require a Pyde Improvement Proposal (PIP) before implementation is accepted. See the PIPs repository for the proposal process. An accepted PIP is then implemented in the relevant repository with the PIP number referenced in the change. Activation and migration rules are defined by the proposal and affected protocol.

Bug fixes that do not alter protocol semantics, tests, documentation, examples, build and CI changes, tooling maintenance, and routine cleanup can proceed as regular pull requests. When a change is borderline, treat it as protocol affecting until the relevant maintainers establish that it is not.

## Engineering standards

The bar for code merged into a main branch includes:

- `cargo build` clean
- `cargo test` passing
- `cargo clippy --workspace -- -D warnings` passing
- `cargo fmt` applied
- New code has tests where the change is non trivial
- New `unsafe` blocks include a documented invariant explaining their safety assumptions
- No new `unwrap()` or `expect()` calls on untrusted input paths without explicit justification and validation

Security relevant components such as cryptography, execution, consensus, state, networking, settlement, and authorization receive deeper review and independent security scrutiny where the risk warrants it.

## Repository structure

Pyde uses multiple repositories around a shared protocol foundation. Repository access and visibility vary by component.

| Area | Scope |
|---|---|
| Protocol core | Execution, state, consensus, accounts, and transactions |
| Settlement infrastructure | Cross domain settlement, FX observations, obligations, positions, and netting |
| Cryptography | Signatures, key exchange, hashing, proof, and state primitives |
| Developer tooling | Contract build, test, deploy, verification, and local development |
| SDKs and interfaces | Client libraries and contract facing APIs |
| Documentation and proposals | Technical documentation and Pyde Improvement Proposals |
| Website | Public architecture and project information |

Repository specific README, CONTRIBUTING, and security policies override this document where they define more specific requirements.

## Pull requests

A pull request should explain what changed, why the change is needed, which protocol or repository boundary it affects, how the change was tested, and any migration, compatibility, or security implications.

For protocol changes, link the relevant PIP directly in the pull request.

## Commit messages

We use a light convention loosely based on Conventional Commits:

```text
<type>(<scope>): <subject>

<body: what + why, not how>
```

Common types include `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `perf`, `style`, and `ci`.

## Security sensitive work

Changes to cryptography, consensus, execution, state, validator logic, authorization, settlement, or cross domain coordination may require focused security review, adversarial testing, reproducible benchmarks where performance claims are affected, and independent audit before production use when the risk profile warrants it.

Security reports must follow SECURITY.md rather than being opened as public issues.

## Communication

Use the issue tracker or pull request discussion of the relevant repository for substantive technical discussion. Protocol design changes belong in the PIP process.

## Code of Conduct

This project follows the Contributor Covenant in CODE_OF_CONDUCT.md. By participating, you agree to follow it.

## License

Follow the LICENSE file in the repository receiving the contribution. Repository specific licensing terms take precedence over this organization wide guide.
