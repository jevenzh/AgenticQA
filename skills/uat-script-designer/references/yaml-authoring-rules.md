# YAML Authoring Rules

These scripts are written for humans first, with a stable structure second.

## Authoring Rules

- keep one business scenario per file or YAML document
- use stable `scenario_id` values that can be referenced in plans and sign-off records
- each step must contain one `action` and one observable `expected` outcome
- keep actions executable by a human without hidden assumptions
- write `expected` outcomes in business language, not implementation detail
- make `evidence` explicit whenever acceptance is not self-evident

## Anti-Patterns

- merging multiple flows into one giant script
- using vague steps such as "verify it looks correct"
- omitting preconditions or seeded data assumptions
- mixing automation commands and human instructions in the same step

## Theory and Practice Anchors

- YAML is used here as a portable structured-document format, not as an execution language.
- The quality bar comes from acceptance-test clarity and traceability practices from ISTQB and ISO/IEC/IEEE 29119, not from YAML itself.
