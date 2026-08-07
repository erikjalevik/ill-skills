---
name: ill-work
description: Execute implementation work in a structured way following a spec (plan or task description).
---

# Work

Do high-quality, robust implementation work test-first following a spec in the form of a plan, task or plain prompt.

## Rules of working

- **Follow standards** - Always adhere to standards and conventions given in AGENTS.md or CLAUDE.md.
- **KISS** - Before writing any code, ask: "What is the simplest thing that could work?" Would a staff engineer look at this and say "why didn't you just..."?
- **Stay in scope** - Touch only what the task requires. Don't "clean up" adjacent code or pre-existing issues.
- **Test continuously** - Write tests as you go, not after finishing implementation.

## Process

### 1. Check branch

- If we're on branch main/master, stop and ask user to confirm if we really should do the work on main.
- If we're already on a feature branch, go ahead.

### 2. Identify spec and intent

Look for the originating spec, in this order:

1. A path to a plan or a task doc the user passed as an argument.
2. If none is given, use the instructions in the prompt as the spec.
3. If the intent is unclear or ambiguous, stop and ask the user.

Read the spec.

### 3. Scan the work area

- Find existing test files for areas the work will touch (search for test/spec files that import, reference, or share names with the implementation files).
- Note local patterns and conventions.

### 4. Create todo list

- When a plan with U-IDs for Implementation Units exists, use them verbatim as the todo list.
  - Preserve the unit's U-ID as a prefix in the todo title (e.g., "U3: Add parser coverage"). This keeps blocker references, deferred-work notes, and final summaries anchored to the same identifier the plan uses, so progress and traceability remain unambiguous across plan edits.
- When the spec is just some prose, break the work into logical implementation units. Each unit should represent one meaningful change that could land as an atomic commit. Each unit gets a stable **U-ID** (`U1`, `U2`, …).

### 5. Decide execution strategy

- Evaluate whether the plan is large enough to warrant spawning subagents.
  - A plan with depth `deep` should almost always spawn agents. 
  - A `light` plan should almost always execute inline.
- If you decide to use subagents, decide whether parallel subagents are an option:
  - **Use parallel spawning if**: units don't depend on each other and can complete their work independently without blocking each other.
  - **Use serial spawning if**: units have dependencies between each other or rely on work on another unit having been completed before they can be implemented.
  - Give the agent the implementation unit description, the full text of step 6 below, plus all required context it needs to carry out its work.

### 6. Execute

Proceed using TDD unless otherwise instructed, or the code does not need tests (dev-mode-only code, config scripts etc). Use the `ill-write-test` skill for writing the tests. Tests are proof — "seems right" does not count as done.

Follow project-local guidance in AGENTS.md for how to run the below steps.

1. Write unit tests first, run them and verify they fail (red).
2. Implement the unit.
3. Run its tests again, and iterate on the code until they pass (green).
4. With tests green, review and refactor if needed: extract shared logic, improve naming, remove duplication
5. Run tests again, only proceed wheen green.
6. Run any type checker, and fix any issues.
7. Run any automatic code formatting tools (linter with autofix flag, prettier format etc.) that the project has set up.
8. Run any linter, and fix any remaining issues manually.
9. Commit each unit to the current branch.

#### Commit format

- Do not use conventional commits. 
- Title should be a phrase in imperative tense using sentence case: "Disable the static analyzer".
- Description should provide extra context if necessary: "It generated a lot of false positives inside spdlog."
- Description is optional; only add it if there is genuine rationale or intent to communicate, which is not obvious from the title or the code committed.
- Description should NOT narrate what the code does.

### 7. Verify

- Run the full test suite, type checker, linter etc inline once more at the end.
- If you have a way to do so, run the app in dev mode, and verify everything works.
- Fix any remaining issues.

## Failure modes to avoid

- **Skipping clarifying questions** - Ask for clarification upfront, not after building wrong thing.
- **Ignoring plan references** - The plan has links for a reason.
- **Testing at the end** - Test continuously or suffer later.
- **Forgetting to track progress** - Update task status as you go or lose track of what's done.
- **80% done syndrome** - Finish the feature fully, don't move on early, don't take shortcuts.
