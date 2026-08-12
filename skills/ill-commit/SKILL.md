---
name: ill-commit
description: Rules for writing git commit messages. Use when asked to commit changes.
---

# Commit

## Message

- Message should be an imperative headline using sentence case of max 50 characters.
  - Example: "Disable the static analyzer".
- The message records the *what*.
- Do not use conventional commit format.

## Description

- Description should be written as a bullet point list or a paragraph.
  - Example: "It generated a lot of false positives inside spdlog."
- The description records the *why*.
- Only add a description if there is genuine rationale or intent to communicate that cannot otherwise be gleaned from reading the code.
- Do not add manual line breaks inside the description text.
- Add the model attribution tag at the bottom of the description: "Co-Authored-By: [model name]"
- **Keep it short:** One paragraph of description max. No essays.
- **Record the why, not the how:** Description is for additional context. Never restate or narrate what the code already says. 
