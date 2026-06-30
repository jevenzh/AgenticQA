# Quarantine Policy

Quarantine is a temporary control for trust restoration, not permanent storage.

## Minimum Contract

- owner
- date added
- expiry date
- reason for quarantine
- exit condition

## Rules

- unowned quarantines are invalid
- expired quarantines are governance failures
- quarantine should reduce false signal, not hide product defects indefinitely

## Theory and Practice Anchors

- release governance practice: exception handling must remain visible and time-bounded.
- CI health management: trust declines quickly when unstable tests remain indefinitely in the active suite.
