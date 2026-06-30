---
description: Build a stage-based quality gate matrix for a change/release and identify release blockers.
mode: agent
argument-hint: <"current diff", PR, or release scope>
---

# Quality Gates

Create quality gates for: **$ARGUMENTS**

Steps:

1. Route through `qa-governance-workflow` and its references to define gate purpose, threshold quality, and waiver control rules.
2. Assess risk level (low/medium/high) with rationale.
3. Build the gate matrix for Local, PR, Pre-release, and Post-release stages.
4. Record per-gate owner, threshold, and block behavior.
5. Call out blocking conditions and current blockers.
6. Record waivers with approver, expiry, and compensating controls.
7. If authoring a local markdown artifact, validate it with `skills/qa-governance-workflow/scripts/validate-gate-matrix.sh <file>` when applicable.
8. Produce immediate actions to move red/yellow gates to green.
