# Facilitator Guide

## Recommended 90-minute flow

| Time | Activity |
|---:|---|
| 0-7 min | Tell the fleet-state and Behavior Tree refactoring user story. |
| 7-12 min | Explain the trust boundary: Python explores, models propose, Lean certifies. |
| 12-32 min | Run the lifecycle + sensor + log + actuator exercise. |
| 32-67 min | Run the Behavior Tree to handwritten FSM refinement exercise. |
| 67-77 min | Demonstrate the VDA 5050-inspired semantic trace monitor. |
| 77-87 min | Demonstrate the perception-planner uncertainty contract. |
| 87-90 min | Summarize what scales to richer traces, standards, and uncertainty sets. |

## Live commands

```bash
./workshop scenario start lifecycle
./workshop scenario check

./workshop scenario start bt
./workshop scenario check

./workshop scenario solution vda
./workshop scenario check

./workshop scenario solution uncertainty
./workshop scenario check
```

The starter pair is intentionally incomplete. Let participants inspect the
Python failure and the Lean goal before using `scenario solution`.

## Pre-event acceptance

Ask participants to complete exactly these commands before arrival:

```bash
./workshop setup
./workshop check
```

Collect only the final success/failure summary, not API keys or machine data.
Provide `./workshop setup --lean-only` as the fallback for participants who do
not need the Google ADK portion.

After the first successful setup on the reference machine, commit the generated
`lake-manifest.json` and `uv.lock`. Re-test from a clean clone before publishing
the participant instructions.

## Event infrastructure

- Put participants in pairs or groups of three.
- Prefer participant-local Lean, Lean Copilot, and Python execution.
- Use Gemini through event credits or participant accounts only for the optional
  agent section.
- Keep any large local model on a separate, rate-limited escalation endpoint.
- Prepare an offline copy of the repository, Mathlib cache, Python wheels, and
  Lean Copilot model cache on external storage.
- Never make the workshop depend on one shared 119B model serving every laptop.

## Failure plan

If cloud access fails, the complete core workshop still works locally. If Lean
Copilot models are unavailable, demonstrate `exact?`, `apply?`, `rw?`, `simp?`,
and `aesop?`, then use the checked reference solutions. The VDA and uncertainty
demos can be shown directly with `scenario solution`.

## Claim discipline

- The lifecycle model adds application resource invariants around a simplified
  ROS 2 lifecycle; it is not a full ROS 2 implementation.
- The BT model is a single-tick Fallback of condition-action branches and omits
  `RUNNING`, asynchronous actions, and blackboard state.
- The VDA model is a teaching profile, not full-standard certification.
- The uncertainty model uses one-dimensional integer intervals, not a complete
  perception or motion-planning model.
