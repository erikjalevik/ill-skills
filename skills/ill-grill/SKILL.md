---
name: ill-grill
description: Grill the user about a plan, decision, or idea. Use when a request is unclear, the user wants to stress-test their thinking, tease out requirements, or uses any 'grill' trigger phrases.
---

# Grill

Interview me relentlessly about every aspect of this until we reach a shared understanding. Walk down each branch of the decision tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.

Ask the questions one at a time, waiting for feedback on each question before continuing. Asking multiple questions at once is bewildering.

If a *fact* can be found by exploring the environment (filesystem, tools, web search etc.), look it up rather than asking me. The *decisions*, though, are mine — put each one to me and wait for my answer.

## Process

### Continously estimate confidence

In each round of questioning, write down your current best guess of what I want in **one sentence**, plus an honest confidence number (0–100%). The number forces honesty. If you wrote down a high number but can't actually predict the user's reactions to the next three questions you'd ask, the number is wrong.

Do not stop questioning until you have 95% confidence or I confirm we have reached a shared understanding.

### Challenge against the facts

When the user uses a term that conflicts with the project's existing terminology, call it out immediately. "Your glossary defines 'cancellation' as X, but you seem to mean Y — which is it?"

### Sharpen fuzzy language

When the user uses vague or overloaded terms, propose a precise canonical term. "You're saying 'account' — do you mean the Customer or the User? Those are different things."

### Discuss concrete scenarios

When domain relationships are being discussed, stress-test them with specific scenarios. Invent scenarios that probe edge cases and force the user to be precise about the boundaries between concepts.

### Cross-reference with code

When the user states how something works, check whether the code agrees. If you find a contradiction, surface it: "Your code cancels entire Orders, but you just said partial cancellation is possible — which is right?"
