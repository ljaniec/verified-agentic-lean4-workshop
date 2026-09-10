# From Hallucination to Proof

**Trustworthy AI-assisted robotics development with Gemini and Lean 4**

This repository is the participant-facing working version of a 90-minute
hands-on workshop on AI-assisted formal verification for robotics software.
Language models may propose, explain, falsify, and repair. Lean 4 is the
independent verification authority.

The live workshop, repository content, code, and participant-facing technical
material are all in English.

## Core principle

```text
model proposal != proof

proposal -> executable check -> Lean compilation -> verified or rejected
```

## Start here

Before the event:

```bash
./workshop setup
./workshop check
```

Then follow the numbered participant curriculum:

**[`curriculum/README.md`](curriculum/README.md)**

The curriculum contains one folder per stage and one subfolder per concrete
task or demo step, with exact commands, expected observations, non-spoiling
hints, completion criteria, and recovery guidance.

If you fall behind, use [`curriculum/CATCH_UP.md`](curriculum/CATCH_UP.md). If a
command fails unexpectedly, start with
[`docs/participant-debugging.md`](docs/participant-debugging.md).

## Workshop path

The 90-minute version contains two participant exercises and three short guided
segments:

1. ROS 2-style lifecycle + sensor + log + actuator resources;
2. Behavior Tree to handwritten FSM refinement;
3. VDA 5050-inspired temporal-conformance demo;
4. perception-planner contract under uncertainty demo;
5. Gemini-assisted proposal/rejection/repair demo, when the tested integration
   is available, with a deterministic local fallback.

Available starter scenarios are:

```bash
./workshop scenario list
./workshop scenario start lifecycle
./workshop scenario start bt
./workshop scenario start vda
./workshop scenario start uncertainty
```

The active files are:

```text
playground/current/Current.lean
playground/current/current.py
```

Check exactly that pair with:

```bash
./workshop scenario check
```

Participant work is automatically backed up under `playground/backups/` before
another starter replaces it. Optional trace-level stretch theorems are not
predeclared in the baseline starters, so skipping them cannot block completion
of the required scenario.

## Reference solutions are intentionally absent

The participant branch contains no completed Lean proofs or Python reference
implementations and provides no `scenario solution` command.

Reference answers are maintained separately for facilitator preparation and
post-workshop study. A separate Git branch prevents accidental spoilers but is
not access control: if this repository is made public before the event, the
reference branch should remain unpublished/private until the workshop ends.

## Lean Copilot

The project pins Lean 4.28, Mathlib 4.28, and Lean Copilot 4.28. In an exercise,
participants may try commands such as:

```lean
suggest_tactics
search_proof
select_premises
```

A generated suggestion is still only a candidate until the exact file compiles.

## Optional Google agent layer

The repository contains a constrained Google ADK/Gemini prototype for the final
agentic-verification demonstration. It is optional and remains separate from
the Lean-only participant path while integration is being finalized.

The intended boundary is:

```text
Gemini proposal
    -> constrained tool call
    -> Lean checker
    -> verifier feedback
    -> repair
```

The agent receives no arbitrary shell tool. It may inspect the active
participant Lean file and the shared workshop scenario models, and it must not
report a proof as verified unless the actual Lean checker succeeds.

For the current API-key prototype, copy `.env.example` to `.env` and set both
`GOOGLE_API_KEY` and `GOOGLE_MODEL` before starting the agent. The model name is
intentionally not hard-coded: the exact event model must be selected and tested
end to end before the workshop configuration is frozen.

## Lean-only setup

```bash
./workshop setup --lean-only
./workshop check --lean-only
```

For a fast environment test without downloading Lean Copilot model weights:

```bash
./workshop setup --lean-only --skip-models
```

## Local acceptance gate

GitHub Actions are intentionally disabled. Repository validation is local:

```bash
./workshop check
```

This checks the no-Actions policy, Bash syntax, forbidden Lean constructs, the
Lean build and committed playground, Ruff, mypy, and pytest.

## Repository map

```text
curriculum/                 numbered participant steps and demo runbooks
VerifiedAgenticWorkshop/    shared checked Lean models
exercises/                  unsolved Lean and Python templates
playground/                 participant workspace and ignored backups
agents/                     optional Google ADK agent prototype
src/                        constrained verification-tool implementation
tests/                      participant-branch regression tests
docs/                       design, facilitator, and workshop material
scripts/                    implementation behind ./workshop
```

For workshop execution, start with the
[participant curriculum](curriculum/README.md). Development notes remain in the
[facilitator guide](docs/facilitator-guide.md),
[rehearsal checklist](docs/facilitator-rehearsal.md), and
[setup design](docs/setup-design.md).
