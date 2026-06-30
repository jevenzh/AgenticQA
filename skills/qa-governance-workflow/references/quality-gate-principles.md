# Quality Gate Principles

Quality gates turn expectations into explicit release controls.

## Gate Design Rules

Each gate should define:
- signal
- threshold
- owner
- blocking behavior
- escalation path when red or unknown

## Good Gate Behavior

- local gates protect fast developer feedback
- PR gates protect merge quality
- pre-release gates protect launch readiness
- post-release gates protect safe rollout and fast detection

## Theory and Practice Anchors

- shift-left testing guidance: move high-value detection as early as feasible.
- DORA and trunk-based delivery thinking: fast, trusted feedback loops reduce delivery risk.
- ISO/IEC/IEEE 29119 process thinking: entry and exit criteria should be explicit rather than assumed.
