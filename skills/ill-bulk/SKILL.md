---
name: ill-bulk
description: Implement multiple tasks one after the other.
---

# Bulk

Schedule work on a number of smaller tasks based on the input given in the form of tickets.

## Rules of bulking

- **Work serially** - Stay on the same branch and create commits one after another.

## Process

### 1. Check input

- The first argument of the skill will be a list of paths to ticket files, or the path to a folder containing a number of ticket files.
- Read all the tickets up front, and make sure they are clear.
  - If any are unclear, run the ill-grill skill to achieve clarity.
  - If any seem too big for a direct implementation, and would need a plan first, stop and flag this.

### 2. Determine order

- If the ticket names start with numbers, work on them in increasing order from lowest to highest number.

### 3. Implement

- For each task, implement it with the ill-work skill.
- If the task is large, launch a subagent for it, otherwise work inline.

### 4. Move to next

- Wait for the implementation work to complete, then go back to 3 for the next ticket.
