---
name: ill-commit
description: Conventions for writing git commit messages. Use when asked to commit changes.
---

# Commit

## Rules of committing

- **Keep it short** - One title and one paragraph of description max. No essays.
- **Communicate rationale/intent** - ONLY mention context that cannot otherwise be gleaned from reading the code. Never narrate. No essays

## Commit format

- Title should be an imperative phrase using sentence case.
  - Example: "Disable the static analyzer".
- Description can be written as a paragraph of text or as a bullet point list. Description is optional; only add it if there is genuine rationale or intent to communicate.
  - Example: "It generated a lot of false positives inside spdlog."
- Do not use conventional commit format.
