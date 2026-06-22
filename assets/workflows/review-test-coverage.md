---
description: Audit test coverage for the given scope and report meaningful gaps, prioritized by risk. Does not just report coverage % — finds untested behavior.
mode: agent
argument-hint: <module, directory, or "the current diff">
---

# Review Test Coverage

Audit coverage for: **$ARGUMENTS** (default to the current branch diff if empty).

Steps:

1. Determine the scope. If reviewing a diff, run `git diff` against the base branch to find changed code.
2. Run the project's coverage tooling if available; otherwise reason about coverage from the tests that exist.
3. Look past the percentage — identify untested **behaviors**: edge cases, error paths, auth/authorization, concurrency, and boundary values.
4. Rank the gaps by risk (likelihood × impact), not by line count.
5. Produce a prioritized report: each gap with the file/behavior, why it matters, and the suggested test type (unit / API / E2E).
6. Offer to generate the highest-priority missing tests.

Focus on risk-bearing gaps, not cosmetic coverage of trivial code.
