# Task 05 — Agent Proposal, Rejection, and Repair

**Timebox: 7 minutes**

## Goal

Make the trust boundary visible. The model is allowed to be wrong; the verifier
is not.

## Start

```bash
./workshop task start
```

## Guaranteed first failure

In `playground/current/Current.lean`, replace the TODO with:

```lean
rfl
```

Run:

```bash
./workshop task check
```

Lean must reject the candidate.

## Repair with any agent

Give the real Lean diagnostic to Codex, Claude Code, Gemini, Lean Copilot, or a
local model. Ask for the **smallest** repair.

For a generic coding agent:

```bash
./workshop task prompt
```

The repaired candidate is accepted only when the exact local checker succeeds.

## Done

Stop at:

```text
WORKSHOP_TASK_OK 05-agent-loop
```

The lesson is the loop itself:

```text
proposal → rejection → diagnostic → repair → verification
```
