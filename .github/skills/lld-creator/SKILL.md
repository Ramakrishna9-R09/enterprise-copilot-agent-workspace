---
name: lld-creator
description: Convert an approved HLD into a low-level implementation blueprint with file plans, contracts, schemas, and sequencing.
user-invocable: true
---

# lld-creator

## Trigger Condition

Activate this skill when the user invokes `/lld-creator`, asks for an LLD, provides an approved HLD, or requests an implementation blueprint before code generation.

## Execution Instructions

1. Confirm the HLD is approved or explicitly mark all unresolved assumptions.
2. Inspect the repository layout, naming conventions, module boundaries, test conventions, and existing integration patterns.
3. Create a file-level implementation plan that names each file to create or modify and the reason it exists.
4. Define TypeScript function signatures, request and response types, Zod schemas, and service interfaces.
5. Specify API contracts, including method, path, auth requirement, request schema, response schema, and error responses.
6. Define database changes through migration SQL and QueryBuilder usage expectations.
7. Add a Mermaid sequence diagram for the primary flow and any important failure path.
8. Map every failure case to AppError behavior, HTTP status, logging expectation, and user-facing response.
9. Define test strategy for unit, integration, component, and regression coverage.
10. Produce an ordered implementation sequence that minimizes risk and keeps commits reviewable.

## Output Format

Return Markdown with these sections:

1. Title
2. Inputs and Assumptions
3. File-Level Plan
4. Type and Function Signatures
5. API Contracts
6. Database Schema and Migration SQL
7. Mermaid Sequence Diagram
8. Error Handling Matrix
9. Feature Flags and Configuration
10. Test Plan
11. Implementation Order
12. Review Checklist

## Quality Gates

Done means:

1. The LLD is implementable without additional architectural invention.
2. Every changed file has a clear purpose.
3. Zod validation is included for every external input.
4. All routes require JWT middleware with zero exceptions.
5. Database access uses QueryBuilder and never raw SQL in application code.
6. Errors use AppError and logs use the logger utility.
7. Migration SQL is present when persistence changes.
8. No implementation code is written beyond signatures, schemas, contracts, and SQL.
