# Traceability Rules

Traceability is the mechanism that proves why a test exists and what risk it covers.

## Required Trace Fields

Each planned test case should be traceable to:
- requirement, ticket, defect, or change area
- assigned test layer
- priority or risk rating
- owning gate or execution stage
- expected evidence when manual sign-off applies

## Good Traceability Behavior

- one case can trace to multiple requirements if it truly validates them together
- do not invent trace IDs without a source anchor
- if a requirement has no test, mark it as a gap explicitly
- if a test has no requirement or risk anchor, challenge whether it is worth keeping

## Theory and Practice Anchors

- ISO/IEC/IEEE 29119-3 and legacy IEEE 829 documentation practices: trace requirements to test conditions, cases, and results.
- ISTQB Foundation and Advanced syllabi: traceability supports impact analysis, regression selection, and auditability.
