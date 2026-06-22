---
description: Produce a risk-based regression test plan scoped to a change (diff, PR, or release).
mode: agent
argument-hint: <branch, PR, or "the current diff">
---

# Regression Plan

Build a regression test plan for: **$ARGUMENTS** (default to the current branch diff if empty).

Steps:

1. Determine what changed — run `git diff` against the base branch (or read the PR) and list the touched modules.
2. Map the blast radius: what depends on the changed code, and which user-facing flows it can affect.
3. Design the regression scope using risk prioritization (likelihood × impact). Include both the directly changed paths and high-risk adjacent areas.
4. Produce a plan with: Change Summary, Impacted Areas, Regression Test Cases (by type and priority), Test Data/Environments, and Out of Scope.
5. Flag any change that lacks corresponding automated coverage and recommend whether to add it now.

Keep the scope proportional to the change — do not propose a full-suite rerun when a targeted set covers the risk.
