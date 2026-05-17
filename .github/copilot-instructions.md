# Enterprise Copilot Instructions

These instructions are permanent working memory for every Copilot agent in this repository. Follow them unless a human explicitly overrides them in the current task.

## Mission

Turn a Jira ticket into a reviewed, tested, documented pull request inside VS Code while preserving enterprise engineering standards, auditability, and human approval gates.

## Tech Stack

- Backend: Node.js 20, Express, PostgreSQL.
- Frontend: React 18, TypeScript, Tailwind CSS.
- Testing: Jest and React Testing Library.
- Validation: Zod always, no exceptions.
- Error handling: use the `AppError` class. Never throw raw errors.
- Logging: use the `logger` utility. Never use `console.log` in production code.
- Database: use the `QueryBuilder` wrapper. Never use raw SQL in application code.
- Auth: JWT middleware is required on all routes with zero exceptions.
- Secrets: environment variables only. Never hardcode credentials, tokens, private URLs, or secrets.
- Async: use `async` and `await` only. Never use callbacks or `.then` chains.

## Atlassian Context

- Jira site: `https://[YOUR_SITE_URL].atlassian.net`.
- Jira project key: `[YOUR_PROJECT_KEY]`.
- Confluence space: `[YOUR_SPACE_ID]`.
- Use `maxResults: 10` on all Atlassian queries to control token usage.
- Always search Confluence before creating pages to prevent duplicates.
- Always comment the Confluence URL on the Jira ticket after page creation or update.

## Architecture Rules

- Services must be stateless.
- Do not introduce global mutable state.
- All external API calls must live in `/src/integrations/`.
- Every route must use JWT middleware.
- Feature flags must be implemented through environment-backed configuration.
- Keep domain logic out of route handlers.
- Keep integration response mapping inside integration adapters.
- Prefer explicit interfaces at service boundaries.
- Any data entering the system from users, clients, queues, files, or external services must be validated with Zod.
- Any persistence change must include a migration plan.

## Error Handling Rules

- Throw `AppError` for expected application failures.
- Include stable error codes for client-handled failures.
- Preserve cause information for diagnostics when wrapping unknown errors.
- Do not leak secrets, stack traces, SQL text, tokens, or provider payloads to clients.
- Log failures with request correlation identifiers when available.

## Logging Rules

- Use structured logging through the repository logger utility.
- Include ticket ID, user ID, request ID, integration name, and entity IDs when relevant.
- Do not log secrets, tokens, passwords, private keys, authorization headers, or full provider payloads.
- Use debug logs for development-only diagnostics and info logs for business events.

## Database Rules

- Use `QueryBuilder` for all application database access.
- Raw migration SQL is allowed only in migration files or LLD migration sections.
- Never concatenate user input into queries.
- Make migrations backward-compatible when possible.
- Include rollback notes for risky schema changes.

## API Rules

- Every endpoint must declare auth, request schema, response schema, and error responses.
- Route handlers should validate input, call services, and map responses.
- Services should contain business rules.
- Integrations should contain external API protocol details.
- Responses must be explicit TypeScript types.

## Frontend Rules

- Use React 18 with TypeScript.
- Use Tailwind CSS according to existing design tokens and layout patterns.
- Validate external data before rendering when it crosses trust boundaries.
- Prefer accessible queries and semantic elements.
- Handle loading, empty, error, and success states.
- Keep API calls in typed client modules rather than component bodies when the pattern exists.

## Testing Rules

- Use Jest for backend and shared TypeScript tests.
- Use React Testing Library for React behavior.
- Target 90% or higher branch coverage for changed logic.
- Cover success paths, validation failures, auth failures, dependency failures, and empty states.
- Mock external integrations at boundaries.
- Tests must assert observable behavior and contract guarantees.

## HLD Standards

Every HLD must include:

1. Overview.
2. System context.
3. Component breakdown.
4. Data flow.
5. External dependencies.
6. Non-functional requirements.
7. Open questions.

## LLD Standards

Every LLD must include:

1. File-level plan.
2. Function signatures with TypeScript types.
3. API contracts.
4. Database schema and migration SQL.
5. Mermaid sequence diagram.
6. Error handling per failure case.
7. Implementation order.

## Pull Request Standards

- PRs must connect back to the Jira ticket.
- PR descriptions must summarize behavior, tests, risk, rollout, and documentation.
- Do not open a PR until tests relevant to changed code pass or failures are documented.
- Request review only after code-reviewer findings have been addressed or explicitly accepted.

## Human Approval Gates

- HLD requires human approval before LLD work begins.
- LLD requires human approval before implementation begins.
- Destructive Jira actions require explicit confirmation.
- Production-affecting config or migration changes require explicit rollout notes.
