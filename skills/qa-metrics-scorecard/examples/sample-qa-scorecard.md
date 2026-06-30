# QA Scorecard

## Scope
- Release/Sprint/Branch: release-2026.27
- Time window: last 2 weeks

## KPI Table
| Metric | Current | Threshold | Trend | Status | Notes |
|---|---|---|---|---|---|
| Escaped defects (P1+) | 3 | <=1 | up | red | checkout regressions |
| DRE | 82% | >=90% | down | yellow | detection too late |
| MTTM | 18h | <=8h | flat | yellow | slow on-call response |
| E2E flake rate | 2.8% | <=2.0% | up | red | unstable smoke suite |

## Risk Summary
- Release confidence is low due to high escaped defects and E2E instability.

## Corrective Actions
| Action | Owner | Due | Priority |
|---|---|---|---|
| Stabilize smoke suite + remove flaky waits | QA lead | 2026-07-01 | P0 |
| Add PR gate for checkout contract tests | Backend lead | 2026-07-01 | P0 |
| Reduce mitigation time via on-call playbook update | SRE lead | 2026-07-02 | P1 |
