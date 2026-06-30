# Metric Selection Rules

Metrics should support decisions, not create dashboard noise.

## Balanced Set

Include a mix of:
- lagging indicators such as escaped defects
- leading indicators such as flake rate or coverage-risk delta
- operational indicators such as detection or mitigation time

## Rule

Do not use only one metric class. Lagging-only metrics are too late; leading-only metrics can miss real customer harm.

## Theory and Practice Anchors

- quality-management practice favors leading and lagging indicator balance.
- DORA and SRE thinking both emphasize trend and outcome, not isolated snapshots.
