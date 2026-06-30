# Reliability Report

## Scope
- Suite/Run: nightly-e2e / build #842
- Time window: last 14 days

## Reliability Summary
- Flake rate: 3.7%
- Budget status: above budget
- Overall status: red

## Flake Hotspots
| Test/Suite | Symptom | Root Cause Class | Frequency | Impact |
|---|---|---|---|---|
| checkout/retry.spec.ts | intermittent timeout | Timing/waits | high | high |
| auth/session.spec.ts | stale state failure | Data-state leakage | medium | medium |

## Quarantine Compliance
| Test | Owner | Added | Expiry | Status |
|---|---|---|---|---|
| checkout/retry.spec.ts | QA Automation | 2026-06-26 | 2026-07-03 | overdue |

## Runtime Budget
| Pipeline Stage | Budget | Observed | Delta | Status |
|---|---|---|---|---|
| PR E2E smoke | 8m | 12m | +4m | red |

## Remediation Plan
| Action | Owner | Due | Priority |
|---|---|---|---|
| Replace fixed waits with web-first assertions | QA Automation | 2026-07-01 | P0 |
| Add deterministic test data reset | Backend QA | 2026-07-01 | P0 |
