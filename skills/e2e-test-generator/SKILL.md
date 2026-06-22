---
name: e2e-test-generator
description: Generate stable end-to-end UI tests (Playwright, Cypress, Selenium) for a user journey, using resilient locators and auto-waiting. Use when the user wants browser/UI flow tests or wants to de-flake existing E2E tests.
---

# E2E Test Generator

Generate end-to-end browser tests that automate real user journeys without flake.

## When to use

The user wants UI/browser test coverage for a user flow, cross-browser checks, or stabilization of flaky existing E2E tests.

## Procedure

1. **Detect the framework.** Playwright, Cypress, Selenium, or WebdriverIO — follow the repo's config and page-object/fixture patterns. Default to Playwright only for greenfield.
2. **Map the journey.** Break the user goal into ordered, verifiable steps (e.g. land → sign in → add to cart → checkout → confirm).
3. **Use stable locators.** Prefer role/label/test-id selectors. Never bind to styling-based CSS/XPath.
4. **Push setup off the UI.** Establish auth and seed data via fixtures or API calls, not by clicking through prerequisite screens.
5. **Assert with auto-waiting.** Use web-first assertions; never insert fixed `sleep`/`waitForTimeout`.
6. **Run and harden.** Run headless; on failure read trace/screenshots and fix the root cause. Ensure each test is isolated and parallel-safe.

## Quality bar

- Covers a complete journey and passes reliably on repeat runs.
- No fixed sleeps; waits are condition/assertion based.
- Locators are user-facing and stable.
- Tests set up and tear down their own state.

## Anti-patterns to avoid

- `sleep(n)` to "fix" timing.
- Selecting by auto-generated class names or deep CSS paths.
- Tests that depend on a prior test having run.
- Driving login/seed steps through the UI on every test.
