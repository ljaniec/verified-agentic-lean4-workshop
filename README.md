# From Hallucination to Proof

**Verified AI agents with Gemini, Google ADK, Lean Copilot, and Lean 4**

This private starter repository supports a hands-on workshop on trustworthy
AI-assisted formalization of robotics software. Language models may plan,
propose, explain, falsify, and repair. Lean 4 is the independent verification
authority.

The live workshop will be delivered in Polish. All repository content, code,
and participant-facing technical material is written in English.

## Core principle

```text
model proposal != proof

proposal -> executable check -> Lean compilation -> verified or rejected
```

## Two-command setup

Install Git, Git LFS, and Lean through `elan`. Install Python 3.11/3.12 and `uv`
for the Python and Google ADK portions.

```bash
./workshop setup
./workshop check
```

Lean-only setup:

```bash
./workshop setup --lean-only
./workshop check --lean-only
```

For a fast environment test without Lean Copilot model weights:

```bash
./workshop setup --lean-only --skip-models
```

## First workshop scenarios

The 90-minute version uses two exercises and two short demonstrations:

1. ROS 2 lifecycle + sensor + log file + actuator resources;
2. Behavior Tree to handwritten FSM refinement;
3. VDA 5050-inspired semantic trace monitoring;
4. perception-planner contract over an uncertainty interval.

Every scenario has an unsolved Lean template, an unsolved Python template, and
checked reference solutions in both languages.

```bash
./workshop scenario list
./workshop scenario start lifecycle
./workshop scenario status
./workshop scenario check

# Reveal the reference pair when needed.
./workshop scenario solution lifecycle
./workshop scenario check
```

The currently loaded files are placed in:

```text
playground/current/Current.lean
playground/current/current.py
```

Before another starter or solution is loaded, the current pair is backed up
under `playground/backups/`. The scenario checker rejects explicit proof holes,
treats Lean warnings as errors, compiles the exact Lean file, and executes the
matching Python program.

The instructor can validate every committed reference pair with:

```bash
./workshop scenario verify-solutions
```

See [the scenario guide](docs/scenarios.md),
[the 90-minute plan](docs/workshop-plan.md), and
[the live demonstration script](docs/live-demo-script.md).

## Lean Copilot

The project pins Lean 4.28, Mathlib 4.28, and Lean Copilot 4.28. In an exercise,
participants can try:

```lean
suggest_tactics
search_proof
select_premises
```

Generated suggestions remain candidates until the exact file compiles.

## Google ADK tutor

Copy `.env.example` to `.env`, set `GOOGLE_API_KEY`, and optionally change
`GOOGLE_MODEL`. Then run:

```bash
./workshop agent
# or
./workshop agent-web
```

The agent cannot execute arbitrary shell commands. It can only list, read,
scan, and compile allowed workshop Lean files. It must not report a proof as
verified unless the compile tool returns `status=verified`.

## Aristotle compatibility

The repository is a standard Lake project and can be submitted without source
repackaging:

```bash
export ARISTOTLE_API_KEY=...
./workshop aristotle \
  "Fill the selected proof obligations without sorry or new axioms."
```

## Why LeanDojo is not installed for every participant

Lean Copilot already provides tactic suggestion, proof search, and premise
selection. LeanDojo remains useful for trace extraction, dataset construction,
project-aware premise indexing, and prover evaluation, but is intentionally
outside the default participant setup.

## Local acceptance gate

GitHub Actions are intentionally disabled. Every pull request is checked
locally:

```bash
./workshop check
```

This checks the no-Actions policy, Bash syntax, forbidden Lean constructs, the
Lean build and committed playground, Ruff, mypy, and pytest.

## Repository map

```text
VerifiedAgenticWorkshop/   checked Lean models and reference proofs
exercises/                  unsolved Lean and Python templates
solutions/python/           executable Python reference solutions
playground/                 participant workspace and ignored backups
agents/                     optional Google ADK agent
src/                        constrained Lean tool implementation
tests/                      local Python tests
docs/                       participant and facilitator material
scripts/                    implementation behind ./workshop
```

Read [the participant guide](docs/participant-guide.md),
[the facilitator guide](docs/facilitator-guide.md), and
[the setup design](docs/setup-design.md).
