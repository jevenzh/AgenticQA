# SLO and Budget Principles

A performance result is not actionable without explicit thresholds.

## Minimum Budget Set

Define thresholds for:
- p95 latency
- p99 latency when tail behavior matters
- throughput or completed work rate
- error rate
- resource ceilings when available

## Interpretation Rule

Do not accept a result just because average latency looks acceptable. Tail latency and error growth under load often determine user pain and operational risk.

## Theory and Practice Anchors

- Google SRE principles: SLOs and error budgets create decision-ready reliability thresholds.
- Industry performance engineering practice: percentile metrics are more decision-useful than averages for user-facing systems.
