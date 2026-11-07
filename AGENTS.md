# Agent Contract — 45-Minute Workshop

This repository is designed to be runnable by a human participant **or** by a
coding agent such as Codex, Claude Code, Gemini/Antigravity, or a small local
model-backed assistant.

The workshop is time-boxed. Prefer finishing the current verified checkpoint
over exploring unrelated improvements.

## Mandatory startup protocol

When `WORKSHOP_TASK.md` exists, do this immediately:

1. Read `AGENTS.md`.
2. Read `WORKSHOP_TASK.md`.
3. Run `./workshop task status`.
4. Run `./workshop task start` unless the requested scenario is already active.
5. Work only on the files explicitly allowed by the task.
6. After each meaningful change, run `./workshop task check`.
7. Stop when the task check succeeds and report what was verified.

Do not ask the participant to repeat information already present in these files.

## Trust boundary

AI output is never a certificate.

- A Python result is evidence about concrete executions.
- A Lean theorem is accepted only after the exact file compiles with the pinned
  toolchain.
- Never claim `verified` because a model, IDE, or agent says the code looks
  correct.
- Never weaken the specification merely to make a check pass.

## Forbidden shortcuts

Never add or use `sorry`, `admit`, new axioms/constants introduced as proof
assumptions, `Lean.sorryAx`, `native_decide`, `implemented_by`, or another
mechanism that bypasses the intended proof obligation.

Do not modify the static guard to permit a candidate.

## Participant task policy

Unless `WORKSHOP_TASK.md` explicitly says otherwise, agents may edit only:

```text
playground/current/Current.lean
playground/current/current.py
```

Shared models under `VerifiedAgenticWorkshop/Scenarios/` are the specification
for the exercise. Do not change them to make the participant proof easier.

Do not edit exercise templates during a participant task.

## Branch protocol

The 45-minute course uses checkpoint branches:

```text
workshop/00-build
workshop/00-build-solution
workshop/01-lifecycle
workshop/01-lifecycle-solution
workshop/02-bt-refinement
workshop/02-bt-refinement-solution
workshop/03-vda-trace
workshop/03-vda-trace-solution
workshop/04-uncertainty
workshop/04-uncertainty-solution
workshop/05-agent-loop
workshop/05-agent-loop-solution
```

A task branch contains the unsolved current task. Its `-solution` branch contains
the verified checkpoint. The next task branch is based on the previous solution
branch.

Do not inspect or switch to a `-solution` branch unless the participant
explicitly requests the solution or the workshop tool performs a scheduled
checkpoint transition.

## Fast workflow

Use:

```bash
./workshop task status
./workshop task start
./workshop task check
./workshop task next
```

For a one-line prompt suitable for another coding agent:

```bash
./workshop task prompt
```

## Repository policy

- All repository and workshop material is in English.
- GitHub Actions are intentionally disabled; checks are local.
- Never commit API keys, model weights, tokens, participant data, or generated
  runtime work.
- Keep the Lean-only path independent of cloud credentials.
- Local or cloud models may propose; Lean remains the proof authority.
