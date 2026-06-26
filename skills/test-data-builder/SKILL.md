---
name: test-data-builder
description: Design and implement test data factories, builders, and seed fixtures for a test suite. Covers factory pattern, faker integration, fixture management, and data isolation for parallel test runs. Use when test setup is verbose, fragile, relies on hardcoded values, or causes order-dependent failures.
---

# Test Data Builder

Replace fragile, verbose test setup with clean, maintainable data factories that isolate tests and support parallelism.

## When to use

Test setup is duplicated across many tests, relies on hardcoded IDs or email addresses, breaks when data model requirements change, or tests share mutable fixtures that cause order-dependent failures.

## Procedure

### Step 0 — Context probe

1. Identify the language and test framework.
2. Check for existing factory/fixture tooling:
   - JS/TS: `fishery`, `rosie`, `@faker-js/faker`
   - Python: `factory_boy`, `polyfactory`, `faker`
   - Ruby: `factory_bot` + `faker`
   - Java: custom builders, `java-faker` / `datafaker`
   - Go: custom struct constructors, `gofakeit`
3. Read existing test setup code — identify patterns of repeated data construction, hardcoded values, and shared state.
4. Identify the data layer: ORM models, plain objects, API payloads, or database records.
5. Determine whether tests run in parallel — this changes the isolation strategy.

### Step 1 — Identify what needs a factory

Prioritize entities that appear in many tests. Each factory must:
- Produce a **valid, minimal object by default** — no required overrides
- Accept **per-call field overrides** without changing the default for other tests
- Use **a faker library** for realistic, collision-free defaults
- Never hardcode IDs, emails, or other values that collide across test runs

### Step 2 — Implement factories

Follow the pattern already used in the repo above all else. If none exists, use these idiomatic patterns:

**JS/TS — fishery + @faker-js/faker**
```typescript
import { Factory } from 'fishery';
import { faker } from '@faker-js/faker';
import type { User } from '../src/types';

export const userFactory = Factory.define<User>(() => ({
  id: faker.string.uuid(),
  email: faker.internet.email(),
  name: faker.person.fullName(),
  role: 'user',
}));

// Usage:
const admin = userFactory.build({ role: 'admin' });
const [alice, bob] = userFactory.buildList(2);
```

**Python — factory_boy**
```python
import factory
import factory.fuzzy
from myapp.models import User

class UserFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = User

    id = factory.LazyFunction(lambda: str(uuid.uuid4()))
    email = factory.Faker('email')
    name = factory.Faker('name')
    role = 'user'

# Usage:
admin = UserFactory(role='admin')           # persists to DB
user_obj = UserFactory.build(role='admin')  # in-memory only
```

**Ruby — FactoryBot**
```ruby
FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    name  { Faker::Name.full_name }
    role  { 'user' }

    trait :admin do
      role { 'admin' }
    end
  end
end

# Usage:
admin = create(:user, :admin)   # persists
user  = build(:user)            # in-memory
```

### Step 3 — Choose the right persistence strategy per test type

| Test type | Strategy | Why |
|---|---|---|
| Unit tests | In-memory build (`.build()`, `build_stubbed`) | No DB I/O; tests stay fast and isolated |
| Integration / service tests | Persist per test; rollback in teardown | Real DB behavior; no cross-test pollution |
| API / controller tests | Persist per test; use transaction rollback or explicit delete | Tests the full stack without shared state |
| E2E tests | Seed via API calls, not direct DB writes | Same code path the application uses |

**Parallel test safety**: never use hardcoded IDs, fixed email addresses, or shared database sequences. Use UUID-based IDs and faker-generated unique emails. For E2E tests with usernames or slugs, prefix with a per-run ID (e.g., `test_${runId}_user@example.com`).

### Step 4 — Handle related objects with sub-factories

When an entity requires associated records, create them inside the factory using lazy references:

```typescript
// fishery — lazy association
export const orderFactory = Factory.define<Order>(({ associations }) => ({
  id: faker.string.uuid(),
  userId: associations.user?.id ?? faker.string.uuid(),
  total: faker.number.float({ min: 1, max: 999, fractionDigits: 2 }),
}));
```

Avoid deeply nested factory chains that make debugging difficult. If setup requires more than 2–3 associated objects, consider a named scenario factory or a dedicated seed helper function.

### Step 5 — Migrate existing fragile setup

Identify tests with hardcoded data, copy-pasted setup blocks, or `beforeAll` shared fixtures. Refactor to factory calls in `beforeEach` / per-test setup. Verify tests still pass and are now order-independent.

### Step 6 — Report

State: entities that now have factories, tests refactored to use them, reduction in setup lines, and any remaining hardcoded fixtures with a note on why they were intentionally left.

## Quality bar

- Default factory produces a valid object with no required overrides.
- No hardcoded IDs or email addresses that collide across test runs.
- In-memory build vs persist-to-DB is used correctly per test type.
- Parallel tests cannot share or overwrite each other's factory-created data.

## Anti-patterns to avoid

- Hardcoded `id: 1` or `email: "test@example.com"` in any factory default.
- Persisting records in unit tests (unnecessary I/O).
- A single `beforeAll` fixture shared across the entire suite (order dependence and cross-test pollution).
- Factories with so many required overrides they're no easier than constructing objects by hand.
- Deeply nested auto-created associations that make test output hard to read.
