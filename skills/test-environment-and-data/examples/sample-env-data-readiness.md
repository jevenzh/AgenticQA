# Environment and Data Readiness

## Scope
- Suite/Environment: checkout-e2e / staging

## Environment Prerequisites
| Dependency | Required Version | Present | Notes |
|---|---|---|---|
| PostgreSQL | 15.x | yes | shared with billing tests |
| Redis | 7.x | yes | no namespace isolation |

## Seed and Reset Contract
| Dataset | Owner | Seed Method | Reset Method | Schema Version |
|---|---|---|---|---|
| users | QA | fixture script | truncate + reseed | v12 |
| orders | QA | API seed endpoint | missing | v8 |

## Setup and Teardown Checklist
- [x] Setup is deterministic
- [ ] Teardown removes all created state
- [x] Credentials/secrets are valid and scoped

## Isolation Risks
| Risk | Impact | Mitigation | Owner |
|---|---|---|---|
| shared Redis keys | flaky parallel runs | key namespace per test worker | backend team |

## Readiness Decision
- Ready / Not ready: not ready
- Blocking items: missing order reset path, shared cache namespace.
