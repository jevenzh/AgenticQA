---
description: Generate business-facing UAT test scripts in YAML from a test case design spec, requirement, release scope, or acceptance flow.
mode: agent
argument-hint: <test plan, acceptance flow, feature, or release scope>
---

# Generate UAT Scripts

Generate UAT YAML scripts for: **$ARGUMENTS**

Steps:

1. Confirm whether the input already includes a `test case design spec`; if not, derive the acceptance scenarios first using `test-plan-designer`.
2. Select only scenarios that truly require manual acceptance, business judgment, operational rehearsal, or sign-off evidence.
3. Use `uat-script-designer` to produce YAML scripts with:
   - `suite`
   - `scenario_id`
   - `title`
   - `business_goal`
   - `preconditions`
   - `steps.action`
   - `steps.expected`
   - `postconditions`
   - `evidence`
   - `priority`
   - `owner`
   - `acceptance_criteria`
4. Call out overlaps with automated API or E2E coverage so teams do not execute the same scenario twice without purpose.
5. When files are created locally, run `skills/uat-script-designer/scripts/validate-uat-yaml.sh <file>` before presenting the result.
6. Summarize which acceptance risks are covered, which remain manual-only, and what evidence is expected for sign-off.

If the target is purely code-level or fully machine-verifiable, do not force UAT output.
