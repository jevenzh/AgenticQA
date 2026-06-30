# Test Data Contract Rules

Seeded data should behave like a maintained interface.

## Minimum Contract

- dataset owner
- schema version or compatibility marker
- seed method
- reset method
- isolation assumptions

## Rules

- if reset is undefined, repeatability is unproven
- if ownership is unclear, drift will accumulate silently
- shared mutable fixtures should be treated as risk until proven isolated

## Theory and Practice Anchors

- disciplined test-data management practice treats data as infrastructure, not incidental setup.
- reliable automation depends on explicit seed and reset contracts.
