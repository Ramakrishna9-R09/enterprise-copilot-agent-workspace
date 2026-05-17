---
name: jira-workflow
description: Operate a Jira-first engineering workflow from ticket discovery through implementation notes and pull request updates.
user-invocable: true
---

# jira-workflow

## Trigger Condition

Activate this skill when the user invokes `/jira-workflow`, provides a Jira ticket ID, asks to update Jira, or asks to drive engineering work from Jira context.

## Execution Instructions

1. Read the Jira ticket using the configured Atlassian MCP server with `maxResults: 10` for any search.
2. Extract summary, description, acceptance criteria, linked issues, comments, attachments, priority, labels, and status.
3. Ask for confirmation before any destructive or irreversible Jira operation, including deleting, closing, bulk changing, or overwriting fields.
4. Translate ticket content into engineering context for HLD, LLD, code generation, testing, and review.
5. Keep Jira comments concise, factual, and linked to artifacts such as PRs and Confluence pages.
6. When creating or linking Confluence pages, comment the Confluence URL back on the Jira ticket.
7. Preserve existing ticket content and append new information instead of replacing human-authored context.
8. Produce an audit-friendly status update after each major workflow phase.

## Output Format

Return Markdown with:

1. Jira Ticket Summary
2. Engineering Context Extracted
3. Acceptance Criteria
4. Dependencies and Blockers
5. Actions Taken
6. Links Added
7. Next Recommended Step

## Quality Gates

Done means:

1. Jira data is summarized accurately and traceably.
2. All Atlassian searches use `maxResults: 10`.
3. No destructive or irreversible operation occurs without explicit confirmation.
4. Jira comments are professional and include artifact links when available.
5. The ticket remains the operational source of truth for workflow state.
