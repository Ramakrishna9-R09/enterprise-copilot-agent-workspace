# Full SDLC From Jira

Use this prompt when a human provides a Jira ticket ID and wants the complete enterprise workflow from design through reviewed pull request and documentation.

## Input

- Jira ticket ID.
- Optional implementation notes from the human.

## Pipeline

1. Invoke `jira-agent` to read the Jira ticket from `https://[YOUR_SITE_URL].atlassian.net`, using project key `[YOUR_PROJECT_KEY]` and `maxResults: 10` on all Atlassian queries.
2. Invoke `hld-agent` to produce the HLD documentation only.

STOP. Show output above. Do NOT proceed until human types APPROVED.

3. After approval, invoke `lld-agent` to produce the implementation blueprint only.
4. Verify the LLD includes file-level plan, TypeScript signatures, API contracts, database schema and migration SQL, Mermaid sequence diagram, error handling per failure case, and implementation order.

STOP. Show output above. Do NOT proceed until human types APPROVED.

5. After approval, invoke `code-generator` to implement the approved LLD using repository patterns and `.github/copilot-instructions.md`.
6. Invoke `unit-tester` to add or update Jest and React Testing Library coverage, targeting 90%+ branch coverage for changed logic.
7. Invoke `code-reviewer` to review the resulting changes. The reviewer must not write or suggest specific code.
8. If review findings exist, invoke `bug-fixer` to address only confirmed defects. Repeat `unit-tester` and `code-reviewer` until the verdict is Approve or human accepts residual risk.
9. Invoke `jira-agent` to add a concise Jira update with PR link, test results, and current status. Confirm before any destructive or irreversible Jira action.
10. Invoke `confluence-agent` to search for existing pages, publish or update the HLD and LLD documentation, and comment the Confluence URL back on the Jira ticket.

## Required Final Output

Return:

1. Jira ticket summary.
2. HLD approval status.
3. LLD approval status.
4. Implementation summary.
5. Test commands and results.
6. Review verdict.
7. Fixes applied after review.
8. Jira update status.
9. Confluence page URL.
10. Pull request readiness checklist.

## Non-Negotiable Rules

- Do not skip either human approval gate.
- Do not generate code before the LLD approval gate.
- Do not create Confluence pages before searching existing pages.
- Do not use Atlassian query result limits above `maxResults: 10`.
- Do not perform destructive Jira actions without explicit confirmation.
- Do not open a pull request until relevant tests pass or failures are documented.
