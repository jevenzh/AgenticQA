# Quality Gate Matrix (Example)

## Scope
- Change/Release: PR-2142 payment retry logic
- Risk level: high
- Rationale: checkout path, external dependency, high revenue impact

## Gate Matrix
| Stage | Signal | Threshold | Owner | Block Behavior | Status |
|---|---|---|---|---|---|
| Local | Unit + lint | 100% pass | Feature dev | Block local merge prep | Green |
| PR | Unit/integration/API contract | 100% pass, no contract breaks | Service team | Block merge | Yellow |
| Pre-release | E2E checkout + perf smoke | E2E pass, p95 < 800ms | QA lead | Block deploy | Red |
| Post-release | Canary errors + SLO | error rate < 1%, SLO stable | SRE | Auto rollback | Unknown |

## Blocking Conditions
- Perf smoke failed on p95 latency
- Canary monitors not yet wired

## Waivers
| Gate | Approver | Expiry | Compensating Control | Notes |
|---|---|---|---|---|
| PR contract check | Eng manager | 2026-07-03 | Manual API diff review per merge | Temporary only |

## Remediation Actions
| Action | Owner | Due | Priority |
|---|---|---|---|
| Optimize retry backoff path | Backend team | 2026-07-01 | P0 |
| Add canary alert rule | SRE | 2026-07-01 | P0 |
