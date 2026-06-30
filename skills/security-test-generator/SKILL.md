---
name: security-test-generator
description: Build a security-focused test matrix for application changes, including authn/authz boundaries, abuse cases, and severity-based reporting.
when_to_use: Use when changes affect authentication, authorization, sensitive data, external APIs, or user roles. Triggers include "security testing", "OWASP", "authz checks", "abuse cases", "IDOR", "security regression".
argument-hint: [change-scope|api-surface]
---

# Security Test Generator

Use this skill to ensure changes fail safely and enforce trust boundaries.

## Inputs

- Scope: `$ARGUMENTS`
- Role model and tenant boundaries
- Sensitive data classification

## Procedure

1. Inventory threat surface using `references/owasp-risk-categories.md`:
   - Entry points
   - Trust boundaries
   - Privileged operations
2. Build security test matrix:
   - Authentication failures
   - Authorization boundaries
   - Input validation and malformed payload classes
   - Session and token handling
   - Rate-limit and abuse protections
3. Add abuse cases using `references/authz-abuse-cases.md`:
   - Cross-tenant access attempts
   - Privilege escalation attempts
   - Replay and state-manipulation scenarios
4. Execute and capture evidence.
5. Rate findings by severity and exploitability using `references/security-severity-rating.md`.
6. Mark release blockers and recommended mitigations.
7. If authoring a local markdown artifact, optionally run `scripts/validate-security-report.sh <file>` before presenting it.

## Output contract

Use `templates/security-matrix-template.md`.

Required sections:

- Threat surface summary
- Security test matrix
- Findings with severity + evidence
- Release blockers
- Remediation recommendations

## Guardrails

- Do not report findings without reproduction evidence.
- Do not skip authorization boundary tests.
- Do not treat high-severity findings as non-blocking without waiver.

## Reference assets

- Template: `templates/security-matrix-template.md`
- Example: `examples/sample-security-report.md`
- Validation script: `scripts/validate-security-report.sh`
- Theory/practice reference: `references/owasp-risk-categories.md`
- Theory/practice reference: `references/authz-abuse-cases.md`
- Theory/practice reference: `references/security-severity-rating.md`
