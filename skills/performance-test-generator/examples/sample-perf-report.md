# Performance Report

## Scope
- Service/Flow: checkout submit
- Environment: staging

## Scenarios
| Scenario | Workload | Duration | Objective |
|---|---|---|---|
| baseline | 50 rps | 10m | establish baseline |
| load | 200 rps | 15m | peak readiness |

## Budgets
| Metric | Target |
|---|---|
| p95 latency | < 800ms |
| p99 latency | < 1500ms |
| Throughput | >= 180 rps |
| Error rate | < 1% |

## Results
| Scenario | p95 | p99 | Throughput | Error Rate | Status |
|---|---|---|---|---|---|
| baseline | 420ms | 760ms | 52 rps | 0.1% | pass |
| load | 910ms | 1700ms | 176 rps | 1.7% | fail |

## Bottlenecks
- DB connection pool saturation at peak load.

## Recommendation
- Go / No-go / Conditional: no-go
- Rationale: latency and error budgets exceeded under expected peak conditions.
