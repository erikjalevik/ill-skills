---
name: ill-review
description: "Perform code review on a diff using specialised personas. Runs reviews in parallel sub-agents and reports their findings. Use when new code needs reviewing."
---

# Review

This skill structures how code reviews should be done. It is an orchestrator that dispatches a number of subagent reviewers, passing them each the contents of `./subagent-template.md`, with `${var}` variables substituted as described below.

## Process

### 1. Pin the fixed point to diff against

Whatever the user said is the fixed point — a commit SHA, branch name, tag, `main`, `HEAD~5`, etc. If they didn't specify one, ask for it.

Capture the diff command once: `git diff <fixed-point>...HEAD` (three-dot, so the comparison is against the merge-base). Also note the list of commits via `git log <fixed-point>..HEAD --oneline`.

Before going further, confirm the fixed point resolves (`git rev-parse <fixed-point>`) and the diff is non-empty. A bad ref or empty diff should fail here — not inside parallel sub-agents.

### 2. Identify spec and intent

Look for the originating spec, in this order:

1. A path to a plan or a task the user passed as an argument.
2. A plan file under `docs/plans` matching the branch name or code.
3. A task file under `docs/tasks` matching the branch name or code.
4. If nothing is found, and the diff's intent is not obvious from the prompt, stop and ask the user.

### 3. Decide which subagents to spawn

Specialised reviewers focusing on an individual aspect of code quality are all defined as custom agents modelled as different personas.

Available reviewers:
- Your built-in code review skill, if you are running in a harness that has a built-in code reviewer (e.g. `/code-review` in Claude Code). 
- `correctness-reviewer`
- `spec-compliance-reviewer`
- `project-standards-reviewer`
- `maintainability-reviewer`
- `adversarial-reviewer`
- `testing-reviewer`
- `performance-reviewer`
- `julik-frontend-races-reviewer`

How to decide:
- If the user asks for a specific reviewer persona or personas, run only those.
- If the user asks for a "mini" review, run the correctness-reviewer, spec-compliance-reviewer and project-standards-reviewer. 
- If the user asks for a "maxi" review, run all.

Otherwise evaluate based on the criteria in the below persona table.

#### Dynamic reviewer persona selection

| Agent name | Use when diff includes |
|-------|-------|
| `correctness-reviewer` | Always on. Catches logic errors, edge cases, state bugs, error propagation, intent compliance. |
| `project-standards-reviewer` | Always on. Checks compliance with CLAUDE.md and AGENTS.md and other project conventions. |
| `spec-compliance-reviewer` | Always on. Checks compliance with spec docs. |
| `maintainability-reviewer` | Large or structural work: substantial refactors, new abstractions, file moves, coupling/type-boundary changes, or at least 200 executable changed lines. |
| `adversarial-reviewer` | >=50 changed code lines; auth/payments; persistence writes or event publication; retry/partial-failure or concurrency/ordering semantics; external APIs; or a silent-pass verification mechanism. |
| `testing-reviewer` | Test files, test infrastructure, fixtures, mocks, or harness behavior; or meaningful runtime behavior changed without corresponding test work. |
| `performance-reviewer` | Concrete performance-sensitive behavior: frequent view updates, database/ORM query shape, algorithmic complexity, large loop-heavy transforms, batching/fan-out, or cache policy with material resource impact. |
| `julik-frontend-races-reviewer` | IPC calls, DOM event wiring, timers, async UI flows, animations, or frontend state transitions with race potential. |

Announce your selection of reviewers.

### 4. Spawn parallel reviewer agents

For each agent:
1. Load `./subagent-template.md` and replace the following variables in the "Input prompt" section inside:
  - `${planPath}`: the path to the plan doc, empty string if none found 
  - `${taskPath}`: the path to the task doc, empty string if none found 
  - `${intent}`: a 2-3 sentence summary of the intent for the change; especially important when no plan/task exists
  - `${commitList}`: the list of commits as captured in step 1, empty string if none
  - `${diff}`: the full change set as captured in step 1
2. Spawn the agent with the prepared template, plus any user prompt given directly as input to this skill, and move on to the next agent.

### 5. Present results

Each agent will return its findings as a JSON array, alongside some plain text. Write each reviewer's findings verbatim to disk under `docs/reviews/[descriptive-name-for-this-changeset]/[persona-name].md`.

Then output a summary table with one row per agent, and columns for the number of issues of each severity it found, and one for the total issue count, sorted on total issue count descending. Then scan the reports and count how many times the same issue was reported by each agent. Then output a table with a short issue title, the highest severity reported, and the agent count for each issue, sorted on count descending. Also write these two tables to disk at `docs/reviews/[descriptive-name-for-this-changeset]/summary.md`.
