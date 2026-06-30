---
description: Generate tests for the given target (file, function, endpoint, or user flow). Auto-selects unit, API, or E2E approach based on what is provided.
mode: agent
argument-hint: <file path, function, endpoint, or user flow>
---

# Generate Tests

Generate tests for: **$ARGUMENTS**

Steps:

1. If a `test case design spec` exists, start from it. If not, derive the minimal case inventory before writing tests.
2. Inspect the target and the repository to determine the right test type:
   - Code-level function/class/module → unit/integration tests
   - HTTP/GraphQL endpoint or API spec → API tests
   - User-facing flow or page → end-to-end UI tests
3. Detect and reuse the existing test framework, directory layout, and naming conventions. Do not introduce a new framework.
4. Enumerate the cases to cover (happy path, edge/boundary, error paths, auth where relevant) and state them before writing.
5. Keep business-facing UAT or sign-off scenarios out of automated test code; route those to `generate-uat-scripts` and `uat-script-designer`.
6. Write the tests following repo conventions; isolate time, randomness, network, and filesystem.
7. Run the suite. Fix test-side failures; report any genuine product bugs separately with a minimal reproduction.
8. Summarize what is now covered and what gaps remain.

If the target is ambiguous, ask which test type is intended before proceeding.
