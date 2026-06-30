---
description: Produce a risk-based regression test plan scoped to a change (diff, PR, or release).
mode: agent
argument-hint: <branch, PR, or "the current diff">
---

# Regression Plan

Build a regression test plan for: **$ARGUMENTS** (default to the current branch diff if empty).

Steps:

1. Start from `test-plan-designer` and produce or reuse a test case design spec for the current change.
2. Determine what changed — run `git diff` against the base branch (or read the PR) and list the touched modules.
3. Map the blast radius: what depends on the changed code, and which user-facing flows it can affect.
4. Design the regression scope using risk prioritization (likelihood × impact). Include both the directly changed paths and high-risk adjacent areas.
5. Map required quality gates by stage (Local, PR, Pre-release, Post-release) and list blockers per gate using `qa-governance-workflow` where needed.
6. Include non-functional slices for security, performance, and reliability where applicable.
7. Produce a plan with: Change Summary, Impacted Areas, Regression Test Cases (by type, priority, and trace ID), Quality Gates, Test Data/Environments, Post-release Verification, and Out of Scope.
8. If the plan is authored locally, validate it with `skills/test-plan-designer/scripts/validate-test-plan.sh <file>` when applicable.
9. Flag any change that lacks corresponding automated coverage and recommend whether to add it now or route scenarios to `generate-uat-scripts`.

Keep the scope proportional to the change — do not propose a full-suite rerun when a targeted set covers the risk.
