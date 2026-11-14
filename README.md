# From Hallucination to Proof

**Trustworthy AI Agents with Lean 4** — a 45-minute practical workshop after
the Lean introduction. Materials by Łukasz Janiec; presented by Mariusz Pawlus.

**Start here:** [presentation PDF](presentation/workshop-slides.pdf) ·
[agenda and presenter cue sheet](presentation/workshop-agenda.pdf) ·
[browser tasks](course/browser/README.md) ·
**[print speaker notes](presentation/speaker_notes.pdf)**

The supplied presentation and agenda define this event's content and timing.
The default route is **Lean in the browser**: no installation, Git checkout,
Python environment, API key, or local model is needed during the session.

## Join the workshop in two minutes

1. Open **[live.lean-lang.org](https://live.lean-lang.org/)**.
2. Open [Task 00](course/browser/starters/00_VerificationGate.lean).
   On GitHub, use **Raw**, then copy the **entire file** into the Lean editor,
   replacing its previous contents. Do not copy Markdown fences.
3. Wait for Lean to finish. Task 00 should have no errors or warnings.
4. Follow the [task guide](course/browser/README.md). For each new task, replace
   the editor contents with that task's entire file and edit only the final
   proof after `:= by`.

Tasks 01–04 contain `skip`, which deliberately leaves an **unsolved goal**.
Task 05 contains an intentionally wrong `rfl` proof. These are starting points,
not verified proofs. A task is complete only when Lean accepts the entire file
without errors, warnings, or proof bypasses. Save your text before moving on.

Any human or AI assistant may propose a proof. **The Lean checker decides
whether the exact candidate proves the unchanged theorem.** Never use `sorry`,
`admit`, invented assumptions, `native_decide`, or other proof bypasses.

## The 45-minute route

| Minutes | Task | Paste-ready starter | Claim or observation |
|---:|---|---|---|
| 0–4 | 00 — Verification gate | [Lean](course/browser/starters/00_VerificationGate.lean) | proposer versus checker |
| 4–12 | 01 — Lifecycle resources | [Lean](course/browser/starters/01_LifecycleResources.lean) | repaired step preserves the resource invariant |
| 12–23 | 02 — BT → FSM refinement | [Lean](course/browser/starters/02_BehaviorTreeRefinement.lean) | same decision for all eight observations |
| 23–29 | 03 — Temporal traces | [Lean](course/browser/starters/03_TemporalTrace.lean) | exact stale-update diagnostic |
| 29–35 | 04 — Uncertainty contract | [Lean](course/browser/starters/04_Uncertainty.lean) | point estimate accepts; overlapping interval falls back |
| 35–42 | 05 — Propose, reject, repair | [Lean](course/browser/starters/05_AgentRepair.lean) | `rfl` fails; repair from the real diagnostic |
| 42–45 | Wrap-up | — | model fidelity, assumptions, and the right requirement |

Every task is self-contained. You can move on with the room even if a previous
proof is unfinished. Tasks 03 and 04 can be presenter demonstrations when time
is tight. [Completed slide checkpoints](course/browser/checkpoints/) are for
the scheduled walkthrough or an explicit request for the answer.

## Presenter: rehearse before the room arrives

Use the [facilitator guide](docs/facilitator-guide.md) and the
[rehearsal checklist](docs/facilitator-rehearsal.md). Keep the PDFs and a local
copy of the task files available. The browser service requires a working
connection; prepare the local fallback on your own laptop in advance.

With Lean installed through `elan` and Python 3.11 or newer:

```bash
git clone https://github.com/ljaniec/verified-agentic-lean4-workshop.git
cd verified-agentic-lean4-workshop
./workshop browser check
```

This checks all six completed files with the pinned **Lean 4.28.0**, rejects the
five unfinished/wrong starters, and checks that the exported definitions still
match the shared models. Success ends with `BROWSER_WORKSHOP_OK`.
**No Lake/Mathlib download or cloud credentials are needed for this check.**
The pinned Lean toolchain itself must already be installed for offline use.
The hosted editor may use a different Lean version: its own checker result is
required for the text you paste there.

For a local exercise, copy a starter into the ignored runtime workspace:

```bash
mkdir -p playground/current
cp course/browser/starters/01_LifecycleResources.lean playground/current/Current.lean
# Edit only the final proof, then:
./workshop browser check playground/current/Current.lean
```

Other useful commands:

```bash
./workshop browser list
./workshop browser show 01
./workshop browser show 01 --completed  # scheduled solution walkthrough
./workshop help
```

## Current files only

This branch contains the current browser workshop, checked Lean models and tasks,
current PDFs, and participant/presenter guidance. Superseded courses, unfinished
legacy templates, old presentation drafts, and unused model integrations have
been removed from `main`; Git history preserves them.

Coding-agent users follow [AGENTS.md](AGENTS.md). The slide's
`./workshop task check` remains a compatibility alias for the browser bundle gate.
The current offline participant command is `./workshop browser check FILE.lean`.

## Maintainer checks

```bash
./workshop browser check          # fast event gate: core Lean + Python only
./workshop check --lean-only      # browser gate + full cached Lean project
uv sync --group dev --locked
./workshop check                  # also Ruff, mypy, pytest
```

GitHub Actions are intentionally disabled. Acceptance is local. Generated
runtime work, credentials, and model weights do not belong in Git.

## What was proved?

A checked theorem establishes the stated property of the explicit model under
its assumptions. Lifecycle preservation and BT refinement cover every modeled
input. Tasks 03 and 04 prove the concrete examples displayed in the slides;
they do not by themselves establish a universal protocol or planner theorem.

These examples do not certify a physical robot, the full ROS 2 runtime,
arbitrary asynchronous Behavior Trees, or the complete VDA 5050 standard.
The uncertainty guarantee is relative to a supplied interval; establishing
that it contains the real obstacle is a separate engineering obligation.

A formally checked answer to the wrong question is still the wrong engineering
result.
