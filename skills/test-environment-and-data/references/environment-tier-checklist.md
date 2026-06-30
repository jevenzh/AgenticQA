# Environment Tier Checklist

Environment readiness differs by tier and should be made explicit.

## Typical Tier Checks

- local: toolchain, service dependencies, seed path, credentials scope
- CI: ephemeral setup, secrets injection, parallel isolation, cleanup
- staging: production-like integrations, data reset rules, access control boundaries

## Rule

Do not assume a suite that passes locally is automatically ready for CI or staging.

## Theory and Practice Anchors

- environment-parity and shift-left practice: earlier tiers should catch issues cheaply, but each tier has distinct readiness risks.
- reliable-test operations: environment drift is a primary source of false failures.
