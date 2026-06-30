---
description: Check performance test outcomes against latency/throughput/error budgets and provide release recommendation.
mode: agent
argument-hint: <service, flow, or scenario name>
---

# Performance Budget Check

Evaluate performance budget for: **$ARGUMENTS**

Steps:

1. Route through `performance-test-generator` and its references to justify workload model, SLO thresholds, and scenario type selection.
2. State scenario and workload assumptions.
3. Compare budget targets (p95/p99 latency, throughput, error rate) with observed results.
4. Call out regressions, tail-latency risk, and probable bottlenecks.
5. If authoring a local markdown report, validate it with `skills/performance-test-generator/scripts/validate-perf-report.sh <file>` when applicable.
6. Produce the release recommendation (go/no-go/conditional) with rationale.
