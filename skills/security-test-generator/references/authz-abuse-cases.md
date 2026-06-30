# Authorization Abuse Cases

Authorization failures often hide in ownership, tenancy, and workflow edges rather than simple role checks.

## Default Abuse Cases

For each privileged or data-bearing operation, consider:
- unauthenticated access attempt
- authenticated but under-privileged access attempt
- cross-tenant or cross-owner read attempt
- cross-tenant or cross-owner write/update/delete attempt
- forced browsing to unlinked resources
- stale token or session reuse
- workflow step skipping or direct-state transition attempt

## Quality Rule

Do not mark authorization covered unless both positive and negative role or ownership cases have been exercised.

## Theory and Practice Anchors

- OWASP ASVS and API Security Top 10: broken object-level and function-level authorization are recurrent high-severity issues.
- Risk-based testing guidance: authorization boundaries warrant deep negative testing because impact is typically high even when failure likelihood is uncertain.
