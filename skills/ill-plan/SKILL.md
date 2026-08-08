---
name: ill-plan
description: "Create structured plans for any multi-step implementation task. Use for plan creation when the user says 'plan this', 'create a plan' etc."
---

# Plan

First: if the input is unclear or underspecified, invoke the /ill-grill skill to get clarity.

## Planning rules

- **Decisions, not code** - Capture approach, boundaries, files, dependencies, risks, and test scenarios. Do not pre-write implementation code or shell command choreography. 
- **Research before structuring** - Explore the codebase, docs, and external guidance when warranted before finalizing the plan.
- **Reference names, not lines** - Prefer filenames and class/function names over brittle line numbers.

## Quality bar

Every plan should contain:
- A clear problem frame and scope boundary
- Decisions with rationale, not just tasks
- Existing patterns or code references to follow
- Enumerated test scenarios for each feature-bearing unit
- Clear dependencies and sequencing

## Process

### 1. Assess plan depth

Classify the work into one of these plan depths:

- **Light** - small, well-bounded, low ambiguity
- **Standard** - normal feature or bounded refactor with some technical decisions to document
- **Deep** - cross-cutting, strategic, high-risk, or highly uncertain implementation work

If depth is unclear, continue grilling. Communicate your depth assessment.

### 2. Research

Do local discovery of:

- Architectural patterns and conventions to follow - read AGENTS.md
- Implementation patterns, relevant files, modules, and tests - read relevant skills
- Institutional learnings and previous decisions from `docs/learnings`

Do external web research when:

- The topic is high-risk: security, payments, privacy, concurrency, migrations, compliance
- The codebase lacks relevant local patterns or skills - fewer than 3 direct examples of the pattern this plan needs
- The user is exploring unfamiliar territory

Announce the decision briefly before continuing. Examples:

- "Your codebase has solid patterns for this. Proceeding without external research."
- "This involves payment processing, so I'll research current best practices first."

### 3. Structure

- Find all the requirements that need to be fulfilled. Each requirement gets a stable plan-local **R-ID** (`R1`, `R2`, …).
- Break the work into logical implementation units. Each unit should represent one meaningful change that an implementer could typically land as an atomic commit. Each unit gets a stable plan-local **U-ID** (`U1`, `U2`, …).
- Try finding clean boundaries between the units, with minimal dependencies between them. The ideal separation is one where units can be implemented in parallel.

### Requirement Format

Examples:

- R1. [Requirement or success criterion this plan must satisfy]
- R2. [Requirement or success criterion this plan must satisfy]

### Implementation Unit Format

For each unit, include:
- **Goal** - what this unit accomplishes
- **Requirements** - which requirements or success criteria it advances (cite R-IDs)
- **Dependencies** - what must exist first (cite by U-ID, e.g., "U1, U3")
- **Files** - repo-relative file paths to create, modify, or test (never absolute paths)
- **Approach** - key decisions, data flow, component boundaries, or integration notes
- **Technical design** - optional pseudo-code or diagram when the unit's approach is non-obvious and prose alone would leave it ambiguous. Frame explicitly as directional guidance, not implementation specification.
- **Patterns to follow** - existing code or conventions to mirror
- **Test scenarios** - enumerate the specific test cases the implementer should write, right-sized to the unit's complexity and risk. Pay **particular attention to errors and edges cases**.
- **Verification** - how an implementer should know the unit is complete, expressed as outcomes rather than shell command scripts

**Stability rule.** Once assigned, a U-ID is never renumbered. Reordering units leaves their IDs in place (e.g., U1, U3, U5 in their new order is correct; renumbering to U1, U2, U3 is not).

### 4. Write

**NEVER CODE during this skill.** Research, decide, and write the plan — do not start implementation.

- Draft a clear, searchable title using conventional format such as `feat: Add user authentication` or `fix: Prevent checkout double-submit`
- Build the filename following the repository convention: `docs/plans/YYYY-MM-DD_<type>_<descriptive-name>.md`

Create the following sections:
- Frontmatter with the title, date and plan depth.
- `## Problem Frame`: brief prose problem statement with context
- `## Requirements`: the list of R-IDs and their descriptions
- `## Scope Boundaries`: what the plan will NOT cover
- `## Implementation Units`: the full details of all implementation units, with U-IDs
- `## Risks and Mitigations`: a table of identified risks and how they're addressed
- `## References`: if external sources were used, list them here 

### 5. Review

Before finalizing, check:

- Every major decision is grounded in the problem statement or research
- Each implementation unit is concrete, dependency-ordered, and implementation-ready
- Each feature-bearing unit has test scenarios from every applicable category (happy path, edge cases, error paths, integration) — right-sized to the unit's complexity
- Test scenarios name specific inputs, actions, and expected outcomes without becoming test code
- Deferred items are explicit and not hidden as fake certainty
- Per-unit technical design fields, if present, are concise and directional rather than copy-paste-ready
- If the plan creates a new directory structure, would an Output Structure tree help reviewers see the overall shape?
- U-IDs and R-IDs are unique within the plan and follow the stability rule — no two units share an ID
- Would a visual aid (dependency graph, interaction diagram, comparison table) help a reader grasp the plan structure faster than scanning prose alone?

### 6. Summarise

Write a one-sentence summary of the work done, and announce the path to the full plan, then stop.
