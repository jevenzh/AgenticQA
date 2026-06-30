# OWASP Risk Categories

Use established application-security categories to avoid ad hoc security scope.

## High-Value Categories

For most change-level security planning, consider at least:
- broken authentication
- broken authorization and IDOR/BOLA style access control failures
- injection and unsafe input handling
- sensitive data exposure or weak data protection
- security misconfiguration
- rate-limit or abuse-control gaps
- replay, state-tampering, or workflow abuse

## Selection Rule

Not every category applies to every change. The goal is to justify inclusion or exclusion explicitly based on trust boundaries and data sensitivity.

## Theory and Practice Anchors

- OWASP Top 10 and OWASP API Security Top 10: widely trusted industry baselines for common web and API failure classes.
- NIST SSDF and secure-development practice: threat-informed verification should be part of normal engineering workflow, not a late-stage add-on.
