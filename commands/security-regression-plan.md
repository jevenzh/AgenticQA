---
description: Build a security regression plan for a change, including threat-model deltas, must-run checks, and release blockers.
mode: agent
argument-hint: <"current diff", PR, or release scope>
---

# Security Regression Plan

Create a security regression plan for: **$ARGUMENTS**

Steps:

1. Route through `security-test-generator` and its references to assess applicable OWASP risk categories, authorization abuse cases, and severity-rating rules.
2. Derive the threat-model delta from the current change or release scope.
3. Build the must-run security checks by layer (unit/API/E2E/security), preserving traceability when an upstream test case design spec exists.
4. Explicitly call out abuse-case checks for privilege, tenancy, ownership, and data boundaries.
5. If authoring a local markdown report, validate it with `skills/security-test-generator/scripts/validate-security-report.sh <file>` when applicable.
6. Produce potential release blockers with severity rationale plus recommended mitigations and follow-up tests.
