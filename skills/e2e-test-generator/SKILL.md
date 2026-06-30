---
name: e2e-test-generator
description: Generate stable end-to-end UI tests for real user journeys using the repo's existing browser framework, resilient locators, and deterministic setup. Use when validating flows, adding browser coverage, or deflaking E2E suites.
when_to_use: Use when the user asks for browser or user-flow tests, cross-page regression coverage, or stabilization of flaky E2E suites. Triggers include "E2E tests", "user journey", "Playwright", "Cypress", "de-flake", and "browser regression".
argument-hint: [user-flow|page|journey]
---

# E2E Test Generator

Use this skill to automate complete user journeys without turning the suite brittle.

## Inputs

- Journey scope: `$ARGUMENTS`
- Existing E2E framework, fixtures, and page objects
- Required auth/data/environment setup
- Upstream test case design spec and any UAT candidate scenarios when available

## Procedure

1. Detect the repo's E2E framework and conventions.
2. If a test case design spec exists, start from the E2E-assigned cases and preserve their trace IDs.
3. Define the journey as ordered user-visible milestones.
4. Reconcile automation with manual UAT using `references/e2e-vs-uat-boundary.md`:
   - automate deterministic product behavior
   - leave business-judgment or sign-off steps to UAT YAML scripts
5. Choose stable locators using `references/locator-strategy-guide.md`: role, label, or test id.
6. Move setup off the UI when possible using fixtures or APIs.
7. Ensure environment and seeded data readiness before execution.
8. Write assertions with condition-based waiting only.
9. Run headless, inspect traces/screenshots on failure, and fix root causes rather than adding waits; use `references/flake-root-cause-playbook.md` when triaging flakes.
10. Report flake risks, runtime impact, remaining coverage gaps, and any residual UAT-only scenarios.

## Output contract

Use `templates/e2e-journey-template.md`.

Required sections:

- journey definition
- trace IDs and automated-vs-UAT split when present
- setup and data requirements
- locator strategy
- assertions and success criteria
- flake/runtime risks

## Guardrails

- Do not use fixed sleeps.
- Do not couple tests to styling-based selectors.
- Do not drive repetitive auth/seed setup through the UI when an API/fixture path exists.
- Do not leave tests order-dependent or non-parallel-safe.

## Reference assets

- Template: `templates/e2e-journey-template.md`
- Example: `examples/sample-e2e-journey.md`
- Anti-pattern scan script: `scripts/scan-e2e-anti-patterns.sh`
- Theory/practice reference: `references/locator-strategy-guide.md`
- Theory/practice reference: `references/flake-root-cause-playbook.md`
- Theory/practice reference: `references/e2e-vs-uat-boundary.md`
