---
name: qa-metrics-scorecard
description: Generate a QA scorecard with leading and lagging indicators for release readiness and process health.
when_to_use: Use before release decisions, sprint quality reviews, or when quality trends are unclear. Triggers include "qa scorecard", "release health", "escaped defects", "DRE", "quality KPIs".
argument-hint: [release|sprint|branch]
---

# QA Metrics Scorecard

Use this skill to convert QA telemetry into a clear decision signal.

## Inputs

- Scope: `$ARGUMENTS`
- Defect data, test health signals, and pipeline trends
- Thresholds (team defaults or explicit release thresholds)

## Metric set

- Escaped defects (count + severity)
- Defect Removal Efficiency (DRE)
- Mean time to detect/mitigate (MTTD/MTTM)
- Flake rate by suite
- Pass-rate stability trend
- Coverage-risk delta on changed components

## Procedure

1. Use `references/metric-selection-rules.md` to confirm the metric set is balanced and decision-useful.
2. Collect available metrics and flag missing telemetry.
3. Normalize values to a common time window.
4. Compare each metric against threshold + trend baseline.
5. Assign status: green/yellow/red using `references/scorecard-interpretation.md`.
6. Produce release risk summary and confidence level.
7. Recommend top 3 corrective actions with owners.
8. If authoring a local markdown artifact, optionally run `scripts/validate-qa-scorecard.sh <file>` before presenting it.

## Output contract

Use `templates/qa-scorecard-template.md`.

Required sections:

- KPI table
- Trend interpretation
- Risk summary
- Corrective actions

## Guardrails

- Do not hide missing telemetry; mark as explicit risk.
- Do not provide only raw numbers; include decision impact.
- Do not mark green when critical lagging indicators are unknown.

## Reference assets

- Template: `templates/qa-scorecard-template.md`
- Example: `examples/sample-qa-scorecard.md`
- Validation script: `scripts/validate-qa-scorecard.sh`
- Theory/practice reference: `references/metric-selection-rules.md`
- Theory/practice reference: `references/scorecard-interpretation.md`
