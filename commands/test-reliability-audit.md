---
description: Audit flakiness, quarantine compliance, and runtime budgets for the current automated test portfolio.
mode: agent
argument-hint: <suite path, test tag, or "current CI failures">
---

# Test Reliability Audit

Audit reliability for: **$ARGUMENTS**

Steps:

1. Route through `test-reliability-manager` and its references to classify flake causes and quarantine policy issues.
2. Produce flake hotspots (suite/test + observed behavior).
3. Produce the quarantine table (owner, age, expiry, reason).
4. Assess runtime budget status on critical CI paths.
5. Summarize root-cause categories and trends.
6. If authoring a local markdown artifact, validate it with `skills/test-reliability-manager/scripts/validate-reliability-report.sh <file>` when applicable.
7. Rank top remediation actions by impact.
