# Risk Prioritization Model

Use risk to decide what must be tested first and most deeply.

## Simple Scoring Model

Score each change area from `1` to `5` on:
- `Impact`: business, safety, compliance, revenue, or customer harm if it fails
- `Likelihood`: probability of failure based on complexity, novelty, defect history, or change size
- `Detectability`: how likely the failure is to escape before production

Compute:
- `Risk score = Impact x Likelihood x Detectability`

Use ranges as a guide:
- `50-125`: release-critical; requires strong automated coverage and explicit gate visibility
- `20-49`: significant; requires targeted regression and data/env validation
- `1-19`: lower risk; leaner coverage may be acceptable if blast radius is small

## Escalation Signals

Increase priority when any of these apply:
- auth, payments, privacy, regulated data, or irreversible workflows
- high churn or recently flaky components
- weak observability or low detectability
- cross-system dependencies or migration steps

## Theory and Practice Anchors

- ISO/IEC/IEEE 29119 and ISTQB risk-based testing guidance: anchor the use of risk to drive scope and sequencing.
- Rex Black, *Advanced Software Testing* and ISTQB Advanced Test Analyst materials: widely used practical models for likelihood/impact-based prioritization.
- Microsoft shift-left testing guidance: emphasizes moving high-risk verification earlier in the delivery pipeline.
