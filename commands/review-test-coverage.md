---
description: Audit test coverage for the given scope and report meaningful gaps, prioritized by risk. Does not just report coverage % — finds untested behavior.
mode: agent
argument-hint: <module, directory, or "the current diff">
---

# Review Test Coverage

Audit coverage for: **$ARGUMENTS** (default to the current branch diff if empty).

Steps:

1. Determine the scope. If reviewing a diff, run `git diff` against the base branch to find changed code.
2. Reuse the current `test case design spec` if one exists so coverage is reviewed against intended risk coverage rather than raw file churn alone.
3. Run the project's coverage tooling if available; otherwise reason about coverage from the tests that exist.
4. Look past the percentage — identify untested **behaviors**: edge cases, error paths, auth/authorization, concurrency, boundary values, automated-vs-UAT mismatches, and non-functional risks (security/performance/reliability).
5. Rank the gaps by risk (likelihood × impact), not by line count.
6. For each high-risk gap, state gate impact (which quality gate is blocked or weakened).
7. Produce a prioritized report: each gap with the file/behavior, why it matters, the suggested test type (unit / API / E2E / security / performance / UAT), and any relevant trace ID.
8. Offer to generate the highest-priority missing automated tests or route business-acceptance gaps to `generate-uat-scripts`.

Focus on risk-bearing gaps, not cosmetic coverage of trivial code.
