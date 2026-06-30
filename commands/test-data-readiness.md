---
description: Validate environment and test-data readiness for reliable API/E2E/integration execution.
mode: agent
argument-hint: <suite, environment, or "current change">
---

# Test Data Readiness

Assess readiness for: **$ARGUMENTS**

Steps:

1. Route through `test-environment-and-data` and its references to assess environment tiers and test-data contract quality.
2. Produce environment prerequisites and missing dependencies.
3. Produce the seed/reset data checklist and ownership contract.
4. Assess setup/teardown completeness by suite.
5. Assess isolation and parallel-safety risks.
6. If authoring a local markdown artifact, validate it with `skills/test-environment-and-data/scripts/validate-env-data-readiness.sh <file>` when applicable.
7. Produce required fixes before stable execution.
