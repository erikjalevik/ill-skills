---
name: ill-distill
description: "Distill learnings and new knowledge in the form of ADRs and other documentation after completing substantial work. Use when work uncovers important knowledge not yet recorded that would be useful not to have to rediscover during later tasks."
---

# Distill

Distilling is the act of recording hard-earned knowledge in a succinct format in order to build a collection of decisions, conventions, patterns and practices over time. Solving a problem the first time takes research. Distill it, document it, and the next time work can be done correctly quicker. Knowledge compounds.

## Responsibilities

You create, edit and maintain:
- The project-root `README.md` file.
- The project-root `AGENTS.md` file.
- The project-root `ONTOLOGY.md` file.
- Architectural Decision Records (ADRs) under `docs/learnings/adrs`.

## README.md

`README.md` is an overview and high-level introduction to the project: repo layout, folder structure, architectural layers, scripts, testing etc.

Update it when the project's structure or infrastructure changes. Not expected to happen that often.

## AGENTS.md

`AGENTS.md` is for steering coding agents to follow the conventions of the project: agent behaviour, coding standards, naming conventions, instructions for compiling, linting, running tests, building etc.

Update it when not yet documented conventions and patterns come to light. Updates to `AGENTS.md` are likely to be more frequently needed than to `README.md`.

## ONTOLOGY.md

`ONTOLOGY.md` describes the mental model for all the concepts involved in the project.

Update it when a new term has been discovered and its meaning resolved, or the meaning of an existing term has shifted or become more precise. `ONTOLOGY.md` should be totally devoid of implementation details, or references to code. It is a glossary and nothing else.

### Ontology rules

- **Keep definitions tight.** One or two sentences max. Define what it IS, not how it does what it does.
- **Project-specific terms only.** General programming concepts (timeouts, error types, utility patterns) don't belong even if the project uses them extensively. Before adding a term, ask: is this a concept that has a unique definition in this project?
- **Use groupings.** Split it into sections when it grows if the terms can sensibly be divided into different semantic groups.

### Ontology template

The ontology file is a list of tuples:

```
**term**: {A one or two sentence description of the term}
_Avoid_: {Other terms that should not be used to describe this concept}
```

Example:

```
**invoice**: A request for payment sent to a customer after delivery.
_Avoid_: bill, payment request
```

## ADRs

ADRs live under `docs/learnings/adrs`, and record the **what** and **why** of important decisions.

### ADR rules

Only offer to create an ADR when all three are true:

1. **Hard to reverse** — the cost of changing your mind later is meaningful
2. **Surprising without context** — a future reader will wonder "why did they do it this way?"
3. **The result of a real trade-off** — there were genuine alternatives and you picked one for specific reasons

If any of the three is missing, skip the ADR. If a decision is easy to reverse, skip it — you'll just reverse it. If it's not surprising, nobody will wonder why. If there was no real alternative, there's nothing to record beyond "we did the obvious thing".

### What qualifies

- **Architectural shape.** "We're using a monorepo." "The write model is event-sourced, the read model is projected into Postgres."
- **Integration patterns between contexts.** "Ordering and Billing communicate via domain events, not synchronous HTTP."
- **Technology choices that carry lock-in.** Database, message bus, auth provider, deployment target. Not every library — just the ones that would take a quarter to swap out.
- **Boundary and scope decisions.** "Customer data is owned by the Customer context; other contexts reference it by ID only." The explicit no's are as valuable as the yes's.
- **Deliberate deviations from the obvious path.** "We're using manual SQL instead of an ORM because X." Anything where a reasonable reader would assume the opposite. These stop the next engineer from "fixing" something that was deliberate.
- **Constraints not visible in the code.** "We can't use AWS because of compliance requirements." "Response times must be under 200ms because of the partner API contract."
- **Rejected alternatives when the rejection is non-obvious.** If you considered GraphQL and picked REST for subtle reasons, record it — otherwise someone will suggest GraphQL again in six months.

### ADR template

Build the filename following the repository convention: `docs/learnings/adrs/YYYY-MM-DD_<descriptive-name>.md`

Inside, use the following template:

```
# {Short title of the decision}

{1-3 sentences: what's the context, what did we decide, and why.}
```

That's it. An ADR can be a single paragraph. The value is in recording *that* a decision was made and *why*, not in filling out sections.

## Process

1. Look through the harness's session history and identify all recent sessions that pertain to the same task or plan.
2. Review the full history of these, and the session you are currently in, and extract candidates for documentation. Be picky, it's perfectly fine to decide nothing needs extracted.
3. For each learning, decide whether it fits best as an ADR, or in one of AGENTS, ONTOLOGY, README, and note it.
4. Once you're done, present your candidates. The user has the final word on what gets added.
5. If a plan was used as a starting point for the work, and it's still in the backlog, move it from `docs/plans/backlog` to `docs/plans/done`.
6. Commit.
