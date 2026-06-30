# Locator Strategy Guide

Choose selectors that reflect user intent and survive UI refactors.

## Preferred Order

1. role and accessible name
2. label or placeholder for form controls
3. stable `data-testid` when semantics are insufficient
4. text-only selectors only when wording is intentionally stable

## Avoid

- styling classes
- deep CSS chains
- brittle XPath tied to layout structure

## Theory and Practice Anchors

- Playwright and modern accessibility guidance both favor user-facing semantics over DOM trivia.
- Stable, intent-based selectors reduce flakiness and align tests with observable behavior rather than implementation detail.
