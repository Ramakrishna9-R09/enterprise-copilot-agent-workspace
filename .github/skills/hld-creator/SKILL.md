---
name: hld-creator
description: Create a high-level design from a Jira ticket, product requirement, incident theme, or feature brief.
user-invocable: true
---

# hld-creator

## Trigger Condition

Activate this skill when the user invokes `/hld-creator`, asks for an HLD, provides a Jira ticket ID that needs architectural discovery, or requests a system-level design before implementation.

## Execution Instructions

1. Resolve the source of truth: Jira ticket, pasted requirement, existing issue, or user-provided feature brief.
2. Extract the problem statement, business goal, users, constraints, dependencies, and acceptance criteria.
3. Inspect the repository structure before proposing architecture so the design respects existing boundaries.
4. Identify affected domains, services, integrations, routes, data stores, feature flags, and operational concerns.
5. Document the system context with upstream callers, downstream dependencies, and trust boundaries.
6. Define component responsibilities without prescribing implementation code.
7. Describe the end-to-end data flow, including validation, authorization, persistence, side effects, and observability.
8. Capture non-functional requirements: security, privacy, availability, scalability, latency, data retention, auditability, and rollout safety.
9. List risks, tradeoffs, assumptions, and open questions that require human confirmation.
10. Produce a review-ready HLD suitable for Confluence publication and LLD handoff.

## Output Format

Return Markdown with these sections:

1. Title
2. Executive Summary
3. Goals and Non-Goals
4. System Context
5. Component Breakdown
6. Data Flow
7. External Dependencies
8. Security and Authorization
9. Observability and Operations
10. Non-Functional Requirements
11. Rollout and Feature Flags
12. Risks and Tradeoffs
13. Open Questions
14. Handoff Notes for LLD

## Quality Gates

Done means:

1. The design can be understood without reading the Jira ticket.
2. The design follows repository architecture and `.github/copilot-instructions.md`.
3. No implementation code is included.
4. Auth, validation, logging, error handling, database access, and feature flags are explicitly addressed.
5. External dependencies and failure modes are named.
6. Open questions are concrete and answerable.
7. The document is ready for human approval before LLD begins.
