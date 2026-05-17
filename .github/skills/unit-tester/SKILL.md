---
name: unit-tester
description: Create or improve Jest and React Testing Library tests to reach production-grade branch coverage.
user-invocable: true
---

# unit-tester

## Trigger Condition

Activate this skill when the user invokes `/unit-tester`, asks for tests, requests coverage improvements, or needs verification for generated or modified code.

## Execution Instructions

1. Identify the behavior under test from code, LLD, acceptance criteria, and bug reports.
2. Inspect existing test patterns, factories, mocks, fixtures, and coverage thresholds.
3. Add or update Jest tests for backend services, controllers, validation schemas, integration adapters, and error paths.
4. Add or update React Testing Library tests for user-visible behavior, accessibility roles, async states, and failure states.
5. Cover successful paths, validation failures, auth failures, dependency failures, empty states, and boundary cases.
6. Mock external integrations at module boundaries and avoid network calls.
7. Run the most focused test command available, then broaden to the relevant suite.
8. Report coverage impact and unresolved test risks.

## Output Format

Return Markdown with:

1. Test Scope
2. Files Added or Modified
3. Cases Covered
4. Commands Run
5. Coverage Result
6. Remaining Risks

## Quality Gates

Done means:

1. Tests target 90% or higher branch coverage for changed logic.
2. Tests fail before the fix when feasible and pass after implementation.
3. Tests assert behavior, not implementation details.
4. External services are mocked.
5. Validation, AppError paths, logger side effects, and authorization behavior are covered.
6. React tests use accessible queries before test IDs.
