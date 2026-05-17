# Summary

- Jira ticket:
- Confluence documentation:
- Workflow used:

## Design Gates

- [ ] HLD produced
- [ ] HLD approved by human
- [ ] LLD produced
- [ ] LLD approved by human

## Implementation

- [ ] Code follows `.github/copilot-instructions.md`
- [ ] External inputs validated with Zod
- [ ] Expected failures use AppError
- [ ] Production logs use logger utility
- [ ] Database access uses QueryBuilder
- [ ] All routes use JWT middleware
- [ ] Feature flags are environment-backed when needed

## Testing

- [ ] Jest tests added or updated
- [ ] React Testing Library tests added or updated when UI changed
- [ ] Changed logic targets 90%+ branch coverage
- [ ] External integrations are mocked
- [ ] Validation, auth, and failure paths covered

## Review

- [ ] code-reviewer completed
- [ ] bug-fixer handled confirmed defects only
- [ ] Residual risks documented

## Atlassian

- [ ] Jira updated with PR status
- [ ] Confluence searched before page creation
- [ ] Confluence page created or updated
- [ ] Confluence URL commented on Jira ticket
