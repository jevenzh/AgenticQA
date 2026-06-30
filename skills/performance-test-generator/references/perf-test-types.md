# Performance Test Types

Different performance questions require different test shapes.

## Test Type Purposes

- `Baseline`: establish normal response and throughput under expected load
- `Load`: validate expected peak or near-peak demand
- `Stress`: push beyond capacity to identify failure modes and recovery behavior
- `Soak`: sustain load long enough to expose leaks, degradation, or resource exhaustion

## Selection Rule

Pick the smallest set of test types that answers the release question. Do not run stress or soak tests by habit if the actual decision only requires baseline validation.

## Theory and Practice Anchors

- Classic performance engineering practice separates baseline, load, stress, and endurance/soak because each reveals different risks.
- Capacity and resilience reviews depend on choosing the right scenario, not just generating more traffic.
