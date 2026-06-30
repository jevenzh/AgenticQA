---
name: test-plan-designer
description: Design risk-based test plans, formal test case design specs, regression scope, and actionable test cases from requirements, tickets, specs, or diffs. Use before writing tests, when clarifying coverage strategy, or when preparing business-facing acceptance artifacts.
when_to_use: Use when the user asks for test strategy, regression scoping, case design, requirement traceability, test case design specs, or bug-report structure. Triggers include "test plan", "test case design spec", "regression scope", "what should we test", "risk-based coverage", and "write a bug report".
argument-hint: [requirement|ticket|spec|diff]
---

# Test Plan Designer

Use this skill to turn ambiguous change scope into a traceable QA design package.

## Inputs

- Scope source: `$ARGUMENTS`
- Requirements, tickets, specs, diffs, or observed defect details
- Known delivery constraints: timeline, environments, release risk
- Whether business-side UAT, manual sign-off, or regulated acceptance evidence is required

## Procedure

1. Restate the scope in one or two sentences.
2. Surface risks, assumptions, ambiguities, and open questions.
3. Use `references/test-design-techniques.md` and `references/risk-prioritization-model.md` to choose techniques and justify priority.
4. Design cases using the right technique:
   - equivalence partitioning
   - boundary value analysis
   - decision tables
   - state transitions
5. Assign each case to the correct layer using `references/coverage-layering-guide.md`: unit, integration, API, E2E, security, performance, or manual/UAT.
6. Add traceability from case to requirement or change area using `references/traceability-rules.md`.
7. Separate automated execution from manual/UAT execution so the same behavior is not redundantly specified without reason.
8. Map critical coverage to the stage gate it protects: Local, PR, Pre-release, or Post-release.
9. Define acceptance metrics where relevant: defect escape risk, reliability risk, runtime budget, or release-blocker thresholds.
10. When business acceptance or manual sign-off applies, derive a UAT script pack candidate and identify which scenarios should be handed to `uat-script-designer` for YAML authoring.
11. If authoring a local markdown artifact, optionally run `scripts/validate-test-plan.sh <file>` before presenting it.
12. If the input is a defect, convert it into a minimal reproducible bug report.

## Output contract

Use `templates/test-plan-template.md`.

Required sections:

- Scope
- Risks, assumptions, and open questions
- Test case design spec
- Test cases by layer and priority
- Automated vs manual/UAT coverage split
- Quality gate mapping
- Acceptance metrics
- Test data and environments
- Regression scope
- Out of scope

Conditional sections when acceptance/manual validation applies:

- UAT candidate scenarios
- Business sign-off evidence needs

## Guardrails

- Do not produce vague cases like "test login works".
- Do not duplicate the same assertion at every layer.
- Do not force UAT scripts for purely code-level low-risk changes with no business acceptance need.
- Do not hide unknowns; list them explicitly.
- Do not prioritize by ease of testing over risk.

## Reference assets

- Template: `templates/test-plan-template.md`
- Example: `examples/sample-test-plan.md`
- Validation script: `scripts/validate-test-plan.sh`
- Theory/practice reference: `references/test-design-techniques.md`
- Theory/practice reference: `references/risk-prioritization-model.md`
- Theory/practice reference: `references/coverage-layering-guide.md`
- Theory/practice reference: `references/traceability-rules.md`
- Related skill: `../uat-script-designer/SKILL.md`
