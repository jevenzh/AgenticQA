# Flake Root Cause Playbook

Treat flakiness as a product of uncontrolled timing, data, environment, or shared state.

## Root-Cause Order

1. `Timing`: async work not awaited, background jobs, animations, eventual consistency
2. `Data`: reused accounts, residual records, non-idempotent seeds
3. `Environment`: slow CI agents, missing dependencies, browser drift
4. `Isolation`: order dependence, global state leakage, parallel interference

## Fix Strategy

- replace sleeps with condition-based waiting
- seed or reset test data deterministically
- isolate accounts, tenants, and storage per run
- use traces, screenshots, and logs to prove the failure mode before changing code

## Theory and Practice Anchors

- Fowler's test-pyramid guidance and modern CI practice both argue for keeping UI suites small and stable.
- Google's testing guidance repeatedly treats flake reduction as a reliability engineering problem, not a retry problem.
