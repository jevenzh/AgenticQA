# UAT vs E2E Boundary

Use automated E2E and manual UAT for different purposes.

## Prefer Automated E2E When

- expected results are objective and machine-verifiable
- the journey must run repeatedly in CI
- the main risk is integration correctness, not business judgment

## Prefer UAT When

- business acceptance or operational sign-off is required
- evidence must be reviewed by humans
- success depends on judgment, wording, workflow realism, or regulated approval
- the scenario is rare, high-value, and not cost-effective to automate fully

## Combined Pattern

Use both only when they answer different questions:
- E2E proves the system path works reliably
- UAT proves the business accepts the outcome and evidence

## Theory and Practice Anchors

- ISTQB acceptance testing guidance: distinguishes business-facing acceptance objectives from lower-level technical verification.
- Martin Fowler's practical test pyramid: high-level tests should stay selective because they are slower and more brittle.
