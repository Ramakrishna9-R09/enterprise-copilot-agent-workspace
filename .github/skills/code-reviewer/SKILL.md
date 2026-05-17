---
name: code-reviewer
description: Review changes for correctness, security, maintainability, test coverage, and compliance with enterprise Copilot instructions.
user-invocable: true
---

# code-reviewer

## Trigger Condition

Activate this skill when the user invokes `/code-reviewer`, asks for a PR review, requests pre-merge validation, or wants changed code checked against repository and enterprise standards.

## Execution Instructions

1. Identify the changed files and understand the user-facing behavior being modified.
2. Read the relevant HLD, LLD, Jira ticket, prompt output, and tests when available.
3. Inspect code paths for correctness, edge cases, race conditions, data integrity, security, and authorization gaps.
4. Verify compliance with `.github/copilot-instructions.md`, especially Zod validation, AppError usage, logger usage, QueryBuilder access, JWT middleware, and async/await.
5. Evaluate tests for meaningful assertions, branch coverage, regressions, and frontend accessibility behavior.
6. Check operational readiness: logging context, feature flags, migration safety, rollback behavior, and observability.
7. Report only actionable findings that a developer can fix.
8. Do not write replacement implementation code; explain the defect and expected behavior.

## Output Format

Return Markdown with:

1. Review Verdict: Approve, Request Changes, or Block
2. Findings ordered by severity
3. File and line references where available
4. Risk explanation
5. Required fix outcome without writing code
6. Test gaps
7. Residual risks

## Quality Gates

Done means:

1. Findings are specific, reproducible, and ranked by severity.
2. The review does not suggest or write specific code.
3. Security, auth, validation, data integrity, and test coverage are explicitly considered.
4. Non-issues and style preferences are omitted unless they create real risk.
5. The final verdict is clear enough for a PR owner to act on.
