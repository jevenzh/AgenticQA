# Business Evidence Guidelines

Evidence fields make a UAT script auditable rather than anecdotal.

## Minimum Evidence Set

Capture as applicable:
- actor or role performing the script
- environment and data set used
- timestamps or build version
- screenshots, exported reports, or transaction IDs
- pass/fail decision and sign-off owner

## Evidence Quality Rules

- evidence should prove the expected business outcome, not just that a screen was visited
- when a defect is found, link the failed step and captured evidence directly
- if a regulated or high-risk workflow is in scope, require explicit sign-off criteria before execution

## Theory and Practice Anchors

- ISO/IEC/IEEE 29119 documentation concepts: test execution records and results need objective traceability.
- GAMP 5 style regulated-validation thinking: stricter evidence expectations apply when quality or compliance risk is material.
