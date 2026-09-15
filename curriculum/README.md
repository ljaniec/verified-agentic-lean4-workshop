# Workshop Roadmap

This directory is the participant-facing path through the 90-minute workshop.
Work through the numbered folders in order. Every task folder contains only the
information needed for that step: the objective, exact commands, expected
observation, hints, completion criteria, and a recovery path.

## Answer policy

The participant branch intentionally contains **no reference solutions**.
Completed Lean proofs, Python implementations, facilitator notes, and answer
keys are maintained separately for facilitator preparation and post-workshop
release.

You do not need the completed answers to continue with later stages: stretch
proofs are optional, unfinished work is backed up automatically, and the final
sections are facilitator-led demos.

If you fall behind, follow [`CATCH_UP.md`](CATCH_UP.md). For error diagnosis,
see [`../docs/participant-debugging.md`](../docs/participant-debugging.md).

## Timing

| Time | Stage | Mode |
|---:|---|---|
| 0–10 min | `00-setup-and-trust-boundary` | required, guided |
| 10–30 min | `01-lifecycle-resources` | required exercise |
| 30–62 min | `02-behavior-tree-refinement` | main exercise |
| 62–69 min | `03-vda5050-demo` | facilitator demo |
| 69–76 min | `04-uncertainty-demo` | facilitator demo |
| 76–87 min | `05-gemini-verification-demo` | facilitator demo / optional hands-on |
| 87–90 min | `06-wrap-up` | guided |

The stretch tasks at the end of the lifecycle and Behavior Tree stages may be
skipped without affecting later demos. They are intentionally **not**
predeclared in the baseline Lean starters, so skipping them cannot make the
required scenario check fail.

## Common commands

Prepare the environment before the event:

```bash
./workshop setup
./workshop check
```

Load a scenario:

```bash
./workshop scenario start lifecycle
./workshop scenario status
```

Edit the active files:

```text
playground/current/Current.lean
playground/current/current.py
```

Check exactly those files:

```bash
./workshop scenario check
```

A failing full check is expected while baseline TODOs are incomplete. For an
intermediate Lean task, use the editor goal/error state to confirm that the
specific declaration you just edited is solved; later TODOs may still keep the
whole file incomplete.

Python is used to execute concrete examples and counterexamples; Lean is used
to check universal claims.

## Workshop rule

> AI can propose, explain, and repair. The verifier decides what is accepted.

Generated code is never a certificate by itself. A Lean claim counts as
verified only after the exact participant file compiles under the pinned
project toolchain without forbidden proof bypasses.
