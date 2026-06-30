# Authn and Authz Matrix

Authentication and authorization should be planned separately.

## Minimum Role Matrix

For each protected operation, consider at least:
- unauthenticated caller
- authenticated caller without required permission
- authenticated caller with correct permission
- cross-tenant or cross-owner access attempt when applicable

## Common Gaps

- validating only token presence, not role/scope
- testing admin only, skipping regular-user boundaries
- missing ownership checks on resource-level endpoints

## Theory and Practice Anchors

- OWASP ASVS and API Security Top 10: broken authorization remains one of the highest-risk web/API failure classes.
- Risk-based testing practice: authz boundaries deserve priority because failure impact is usually high.
