---
name: qa-governance-workflow
description: Define and enforce stage-based QA quality gates for a change or release, including blockers, waivers, owners, and immediate remediation actions.
when_to_use: Use when planning release readiness, PR gate policy, or go/no-go decisions. Triggers include "quality gates", "release readiness", "can we ship", "what blocks merge", and "define QA governance".
argument-hint: [change-scope or release-id]
---

# QA Governance Workflow

Use this skill to turn quality goals into enforceable gates.

## Inputs

- Scope: `$ARGUMENTS` (or current diff/release scope if omitted)
- Risk signals: blast radius, user impact, reversibility
- Available test/monitoring signals

## Preflight checklist

1. Confirm what is being released and to whom.
2. Identify critical user journeys and critical APIs.
3. Confirm whether rollout is big-bang, phased, or canary.

## Procedure

1. Classify risk as `low`, `medium`, or `high`.
2. Use `references/quality-gate-principles.md` when defining the gate model for stages:
   - Local
   - PR
   - Pre-release
   - Post-release
3. For each gate, define:
   - Signal
   - Threshold
   - Owner
   - Block behavior
4. Mark hard blockers (P0/P1 regressions, contract breaks, critical vulnerabilities, reliability budget violations).
5. If waivers are needed, record them using `references/waiver-control-rules.md`:
   - Approver
   - Expiry date
   - Compensating controls
6. Produce immediate remediation actions sorted by release impact.
7. If authoring a local markdown artifact, optionally run `scripts/validate-gate-matrix.sh <file>` before presenting it.

## Output contract

Use the template at `templates/gate-matrix-template.md`.

Required sections:

- Risk classification and rationale
- Quality Gate Matrix
- Blocking conditions
- Waiver register
- Remediation plan (owner + due date)

## Guardrails

- Do not output vague gates like "run tests" without thresholds.
- Do not allow waiver without explicit expiry and owner.
- Do not mark green if required signals are missing; mark unknown as risk.

## Reference assets

- Template: `templates/gate-matrix-template.md`
- Example: `examples/sample-gate-matrix.md`
- Validation script: `scripts/validate-gate-matrix.sh`
- Theory/practice reference: `references/quality-gate-principles.md`
- Theory/practice reference: `references/waiver-control-rules.md`
