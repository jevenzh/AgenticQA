# Contract Assertion Depth

A contract test should verify the response envelope, not just one convenient field.

## Assert at the Right Depth

Check as relevant:
- status code
- headers and content type
- body shape and required fields
- error envelope consistency
- pagination or cursor semantics
- idempotency or side-effect expectations

## Anti-Pattern

Avoid tests that assert only `200` or one JSON field while leaving the rest of the contract unverified.

## Theory and Practice Anchors

- consumer/provider contract testing practice: trust comes from stable interface behavior, not a single-path check.
- ISO/IEC/IEEE 29119 documentation discipline supports explicit expected results and interface behavior definition.
