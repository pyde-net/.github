# Security Policy

Pyde is infrastructure for global economic state. Its architecture spans three environments with different authority models: Tier 1 sovereign consortium networks, Tier 2 open interlinking settlement infrastructure, and Tier 3 a permissionless public network.

This policy applies across the pyde-net organization unless an individual repository provides a more specific security policy.

## Reporting a vulnerability

**Do not open a public issue for security vulnerabilities.**

Email: **security@pyde.network**

If that address is unavailable, contact **info@pyde.network**.

Please include a description of the vulnerability, steps to reproduce or a proof of concept, the affected repository or component, your assessment of severity and impact, and whether the issue affects the current implementation, the documented architecture, or both.

We will acknowledge valid reports as promptly as practical and keep the reporter informed during triage.

## Scope

Security reports are relevant to:

- Consensus and finality
- Execution and contract interfaces
- Account and state transition logic
- Cryptographic implementations
- Validator and staking logic
- Authorization and tier boundaries
- Cross domain settlement
- FX data aggregation
- Obligations, positions, and bilateral or multilateral netting
- Networking, synchronization, and state recovery
- SDKs and tooling where a flaw can compromise protocol or user security

A repository may define additional scope in its own security policy.

## Severity classification

| Severity | Examples |
|---|---|
| **Critical** | Unauthorized asset or state transition, consensus failure, double spend, key compromise, signature forgery, or systemic settlement corruption |
| **High** | Validator or network disruption, privilege escalation, authorization bypass, oracle manipulation with material settlement impact, or failure to enforce a tier boundary |
| **Medium** | Significant correctness bugs, partial denial of service, isolated settlement errors, or security weaknesses requiring meaningful preconditions |
| **Low** | Edge case correctness issues, hardening gaps, or documentation issues with security implications |

Severity is determined by impact, exploitability, affected scope, and the conditions required to trigger the issue.

## Coordinated disclosure

Security issues are handled through responsible disclosure. Triage, remediation, testing, and disclosure timing depend on severity, affected components, exploit complexity, and whether coordination with external dependencies or ecosystem participants is required.

The project may publish a security advisory after a fix is available and the disclosure process is complete. Researchers will be credited in public disclosures unless they prefer anonymity.

## Safe harbor

We will not pursue legal action against good faith security research that follows this policy, avoids unnecessary access to private data, avoids destruction or disruption beyond what is required to demonstrate the issue, reports findings promptly, and stops testing once the issue is sufficiently demonstrated.

Good faith research does not include data exfiltration, denial of service against production systems, credential theft, social engineering, or activity unrelated to demonstrating the reported vulnerability.

## Current protocol posture

The current public development environment is Tier 3, the permissionless network.

Tier 1 and Tier 2 define sovereign and interlinking environments that use the same protocol foundation with different authority and execution models. Their security boundaries are first class properties of the architecture.

Architectural targets and measured production performance are treated separately. Performance claims that affect security assumptions, capacity planning, or economic guarantees are validated with reproducible benchmarks rather than assumptions.

Independent security review and adversarial testing form part of production readiness for security critical components.

## Bug bounty

This policy does not establish a standing bug bounty program. Any future bounty or paid security research program will define its eligible assets, reward structure, exclusions, and disclosure terms.

## Cryptographic implementation details

Cryptographic algorithms, library versions, parameters, and implementation notes are maintained with the affected protocol component rather than fixed in this organization wide policy.

Security reports remain welcome for implementation defects and architectural weaknesses in the cryptographic design.

## License

This security policy is licensed under CC0, so it may be copied and adapted freely.
