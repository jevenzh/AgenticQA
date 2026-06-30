---
description: Generate a full QA artifact chain for a change, including test case design spec, automated test planning, and UAT script outputs when acceptance workflows apply.
mode: agent
argument-hint: <requirement, PR, release scope, or feature flow>
---

# Generate QA Artifact Pack

Generate a QA artifact pack for: **$ARGUMENTS**

Steps:

1. Start with `test-plan-designer` and produce a test case design spec with trace IDs, risk prioritization, coverage layering, and automated-vs-UAT split.
2. From that design, derive automated coverage assignments:
   - unit/integration for code-level rules
   - API for contract, validation, and authorization checks
   - E2E for critical user-visible journeys
3. When business acceptance, regulated evidence, or manual sign-off applies, route the relevant scenarios to `generate-uat-scripts` and `uat-script-designer`.
4. Summarize the artifact pack as a single output set:
   - test case design spec
   - automated test plan or generated tests
   - UAT YAML scripts when applicable
   - remaining risks, assumptions, and out-of-scope items
5. Preserve traceability so every major risk or requirement maps to one or more artifacts.
6. If the work is release-significant, recommend follow-up use of `quality-gates`, `test-reliability-audit`, `security-regression-plan`, `performance-budget-check`, and `qa-scorecard`.

Do not force UAT artifacts when the change is purely internal or fully machine-verifiable.
