# E2E vs UAT Boundary

Automated E2E and manual UAT should complement each other, not compete.

## Automate in E2E

- objective user-visible behavior
- cross-page integration flows
- regressions that must run per change or per release candidate

## Leave to UAT

- business acceptance based on judgment or policy interpretation
- evidence collection for sign-off
- rare decision-heavy workflows with low automation return

## Theory and Practice Anchors

- ISTQB acceptance testing separates business acceptance objectives from technical integration checks.
- Fowler's practical test pyramid supports selective E2E coverage backed by stronger lower-level automation.
