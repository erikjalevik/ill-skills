---
name: ill-write-skill
description: How to write agent skills. Use when asked to create a new skill, or update an existing one.
---

# Write skill

A skill exists to wrangle determinism out of a stochastic system. We want predictability — the agent taking the same _process_ every run, not producing the same output.

## Rules for skill writing

- Keep it brief. Skill files should ideally be kept under 100 lines. Keep sprawl in check.
- Keep it focused. A specific instruction should be in **one place only** as a **single source of truth**. This makes skills more maintainable and easier to edit.
- Prune stringently when editing to remove dead weight. Check every sentence for **relevance**: does it still bear on what the skill does? If not, delete the whole sentence rather than trim words from it.
- Custom skills should only be used to encode specific conventions/preferences and to impose consistent structure on behaviour. Only stuff that deviates from default model behaviour needs encoding. Never note down the obvious or repeat general best practices. 
- Try to enforce behaviour by stating the positive target behaviour, rather than focusing on what should not be done. Steering by prohibition can backfire: _don't think of an elephant_ names the elephant and makes it more available, not less. Keep a prohibition only as a hard guardrail you can't phrase positively, and even then pair it with what to do instead.

## Common sections

Some sections that are part of most skills:

- "Rules for the skill in question"
- "Process"
- "Failure modes to avoid"