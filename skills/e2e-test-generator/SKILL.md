---
name: e2e-test-generator
description: Generate stable end-to-end UI tests (Playwright, Cypress, Selenium) using resilient locators, auto-waiting, visual regression, and accessibility assertions. Use for user-flow coverage, cross-browser checks, accessibility validation, or de-flaking existing tests.
---

# E2E Test Generator

Generate end-to-end browser tests that automate real user journeys, catch visual regressions, and enforce accessibility — without flake.

## When to use

The user wants UI/browser test coverage for a user flow, cross-browser checks, visual regression catches, accessibility compliance validation, or stabilization of flaky existing E2E tests.

## Procedure

### Step 0 — Context probe

Before writing anything:
1. Detect the framework and version from config files (`playwright.config.ts`, `cypress.config.ts`, `wdio.conf.ts`, etc.).
2. Read existing page objects, fixtures, and auth helpers — reuse patterns already present.
3. Check CI configuration for headless/parallel settings and browser matrix.
4. Identify how auth and seed data are established — API-level or UI-level setup?
5. Note any existing visual baseline screenshots or accessibility tooling (axe-core, jest-axe, cypress-axe).

### Step 1 — Map the journey using SFDIPOT

Use SFDIPOT as a lens to generate test ideas beyond the obvious happy path:

- **S — Structure**: can the user navigate all reachable states? What happens at structural edges (empty state, maximum items, deeply nested navigation)?
- **F — Function**: does each action produce the expected result? What happens with invalid actions (double-submit, interrupt mid-form)?
- **D — Data**: how does the UI handle empty, minimal, maximal, special-character, and Unicode input? What data persists across sessions?
- **I — Interfaces**: what happens when an API is slow, errors, or returns unexpected data? Does the UI surface errors meaningfully?
- **P — Platform**: does behavior vary by browser, viewport size, locale, or timezone? What assumptions are baked into the implementation?
- **O — Operations**: what happens under concurrent use (two tabs, two users editing the same record)?
- **T — Time**: are there session expirations, timeouts, or date-based logic to exercise?

### Step 2 — Use stable locators and API-level setup

- Prefer: `getByRole`, `getByLabel`, `getByTestId` / `data-testid`
- Never bind to: auto-generated class names, deep CSS paths, or text that changes with copy updates
- Establish auth and seed data via API calls or fixtures — not by clicking through prerequisite screens on every test

### Step 3 — Assert with auto-waiting

- Use web-first assertions: `toBeVisible`, `toHaveText`, `toBeEnabled`, `toHaveValue`
- Never insert fixed `sleep`/`waitForTimeout` — replace with condition-based waits

### Step 4 — Advanced tier

**Visual regression**: capture baseline screenshots at key stable states; diff on subsequent runs.
- Playwright: `await expect(page).toHaveScreenshot('name.png')`
- Scope to stable components, not full pages with dynamic timestamps or avatars
- Update baselines intentionally with `--update-snapshots`; treat unexpected diffs as failures

**Accessibility**: run axe-core assertions at each major page state to enforce WCAG 2.1 AA.
- Playwright: `@axe-core/playwright` → `await checkA11y(page)`
- Cypress: `cypress-axe` → `cy.checkA11y()`
- Fail on `critical` and `serious` violations; report `moderate` as warnings
- Re-check after dynamic content loads (modals, toasts, route changes)

**Core Web Vitals**: assert performance budgets during E2E runs on key journeys.
- LCP < 2.5 s, CLS < 0.1, INP < 200 ms
- Playwright: read via `page.evaluate(() => performance.getEntriesByType('navigation'))` or a PerformanceObserver
- Log values even if not blocking — trend tracking reveals regressions before they become user-facing

### Step 5 — Run and harden

Run headless. On failure: read trace, screenshots, and video; fix root cause — do not add sleeps. Ensure each test sets up and tears down its own state and is safe to run in parallel.

### Step 6 — Report

State: journeys covered, browsers tested, accessibility violations found (category and severity), visual diff results, and Core Web Vitals for key journeys.

## Quality bar

- Covers complete user journeys; passes reliably on repeated runs.
- No fixed sleeps; all waits are assertion- or condition-based.
- Locators are user-facing and stable.
- Tests are isolated and parallel-safe.
- At least one accessibility check per major page or view.

## Anti-patterns to avoid

- `sleep(n)` to "fix" timing.
- Selecting by auto-generated class names or deep CSS paths.
- Tests that depend on a prior test having run.
- Driving login/seed steps through the UI on every test.
- Ignoring accessibility violations as "someone else's problem."
