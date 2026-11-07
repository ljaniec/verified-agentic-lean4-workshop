# Task 00 — Build and Trust Boundary

**Timebox: 4 minutes**

## Goal

Confirm that the expensive preparation was completed before the event and
understand the one rule that governs every later task:

> AI can propose. Lean decides what is accepted.

## Run

```bash
./workshop quickcheck
./workshop task check
```

## With a coding agent

Ask exactly:

```text
Follow AGENTS.md and WORKSHOP_TASK.md. Complete the current workshop task.
```

The agent should run the same local check rather than merely telling you that
the repository looks correct.

## Done

Stop when you see:

```text
WORKSHOP_TASK_OK 00-build
```

Then run:

```bash
./workshop task next
```
