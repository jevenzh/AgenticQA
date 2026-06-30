---
name: performance-test-generator
description: Design and evaluate baseline/load/stress/soak performance tests with explicit SLO thresholds and release recommendations.
when_to_use: Use for performance-sensitive features, release hardening, latency regressions, or capacity concerns. Triggers include "performance testing", "load test", "stress test", "p95", "p99", "can this scale".
argument-hint: [service|flow|scenario]
---

# Performance Test Generator

Use this skill to validate speed, scale, and resilience before release.

## Inputs

- Scope: `$ARGUMENTS`
- SLO/budget targets
- Expected traffic/workload profile

## Procedure

1. Define workload model using `references/workload-modeling-guide.md`:
   - request mix
   - concurrency
   - ramp pattern
2. Set pass/fail budgets using `references/slo-budget-principles.md`:
   - p95/p99 latency
   - throughput
   - error rate
3. Define scenarios using `references/perf-test-types.md`:
   - baseline
   - peak/load
   - stress
   - soak
4. Execute scenarios and collect artifacts.
5. Compare observed results to budgets.
6. Produce release recommendation: go/no-go/conditional.
7. If authoring a local markdown artifact, optionally run `scripts/validate-perf-report.sh <file>` before presenting it.

## Output contract

Use `templates/perf-report-template.md`.

Required sections:

- Scenario definitions
- Budget table
- Results table
- Bottleneck analysis
- Release recommendation

## Guardrails

- Do not run tests without explicit thresholds.
- Do not report averages only; include p95/p99.
- Do not hide error-rate spikes under throughput gains.

## Reference assets

- Template: `templates/perf-report-template.md`
- Example: `examples/sample-perf-report.md`
- Validation script: `scripts/validate-perf-report.sh`
- Theory/practice reference: `references/workload-modeling-guide.md`
- Theory/practice reference: `references/slo-budget-principles.md`
- Theory/practice reference: `references/perf-test-types.md`
