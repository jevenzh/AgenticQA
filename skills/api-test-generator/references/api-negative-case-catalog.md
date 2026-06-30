# API Negative-Case Catalog

Strong API testing proves the service fails safely, not only that it succeeds.

## Default Negative Categories

For each operation, consider:
- missing required fields
- malformed field shapes or types
- boundary values and oversize payloads
- unsupported content type
- authentication missing or expired
- authorization denied or scope mismatch
- nonexistent resource IDs
- conflict or duplicate submission
- rate limit or concurrency edge where relevant

## Selection Rule

Choose the negative cases that correspond to real contract or security risk. Do not auto-generate noise without a rationale.

## Theory and Practice Anchors

- Myers' fault-focused test design: negative and error conditions are first-class test targets.
- OWASP API Security guidance: malformed input and broken auth paths are high-value regression targets.
- ISTQB negative testing principles: invalid and unexpected conditions reveal hidden assumptions.
