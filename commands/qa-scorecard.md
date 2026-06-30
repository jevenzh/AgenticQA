---
description: Generate a QA scorecard for a release, sprint, or current branch health.
mode: agent
argument-hint: <release tag, sprint name, or "current branch">
---

# QA Scorecard

Generate scorecard for: **$ARGUMENTS**

Steps:

1. Route through `qa-metrics-scorecard` and its references to confirm the metric set and interpretation rules.
2. Produce the KPI table: metric, current value, threshold, trend, status.
3. Summarize quality risks and likely release impact.
4. If authoring a local markdown artifact, validate it with `skills/qa-metrics-scorecard/scripts/validate-qa-scorecard.sh <file>` when applicable.
5. Produce the top 3 corrective actions with owners and urgency.
