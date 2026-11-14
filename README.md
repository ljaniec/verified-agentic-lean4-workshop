# From Hallucination to Proof

**Trustworthy AI Agents with Lean 4**

We start with a Lean 4 introduction, then work through six tasks in the browser.
No installation or account is needed. Materials by Łukasz Janiec;
presented by Mariusz Pawlus.

## Start here

1. Open **[Lean Web](https://live.lean-lang.org/)**.
2. Open **[Task 00](course/browser/starters/00_VerificationGate.lean)**.
   On GitHub, select **Raw**, then copy the **entire file** into the Lean editor,
   replacing its previous contents.
3. Wait for checking to finish and inspect **All Messages**.
   Task 00 should have no errors or warnings.
4. Follow the **[task instructions and hints](course/browser/README.md)**.
   For each new task, replace the editor contents with its entire starter file.
   Save your work before moving on.

## The six tasks

- **[00 — Verification gate](course/browser/starters/00_VerificationGate.lean):**
  see Lean accept a proof and reject a false claim.
- **[01 — Lifecycle resources](course/browser/starters/01_LifecycleResources.lean):**
  prove that a repaired lifecycle step preserves safe resource use.
- **[02 — Behavior Tree to FSM](course/browser/starters/02_BehaviorTreeRefinement.lean):**
  prove that both decision functions agree for every modeled observation.
- **[03 — Temporal traces](course/browser/starters/03_TemporalTrace.lean):**
  prove the monitor's diagnostic for a stale update.
- **[04 — Uncertainty contract](course/browser/starters/04_Uncertainty.lean):**
  check how an uncertainty interval changes a planning decision.
- **[05 — Propose, reject, repair](course/browser/starters/05_AgentRepair.lean):**
  repair a rejected proof using Lean's diagnostic.

Each task is independent, so you can move on with the group even if a previous
proof is unfinished. Tasks 01–04 deliberately start with an unsolved goal
(`skip`); Task 05 starts with a wrong proof (`rfl`).

For Tasks 01–05, edit only the final proof after `:= by`. Keep the definitions
and theorem statement unchanged. A task is complete when Lean accepts the
entire file without errors, warnings, or proof bypasses such as `sorry`,
`admit`, invented assumptions, or `native_decide`.

You or an AI assistant may propose a proof; **Lean checks it**. These proofs
establish properties of the explicit models and assumptions. Tasks 03 and 04
check concrete examples. They do not certify an entire robot or protocol.

## Workshop materials

- [Presentation PDF](presentation/workshop-slides.pdf)
- [Speaker notes — printable PDF](presentation/speaker_notes.pdf)
  · [editable source](presentation/speaker_notes.md)
- [Completed proofs](course/browser/checkpoints/) — open when the presenter
  shows the solution or when you want to check your answer.
- [Offline setup](docs/offline-mode.md) and
  [troubleshooting](docs/troubleshooting.md)

## Optional: check locally

With Lean installed through `elan` and Python 3.11 or newer:

```bash
git clone https://github.com/ljaniec/verified-agentic-lean4-workshop.git
cd verified-agentic-lean4-workshop
./workshop browser check
```

This checks all six completed files and the expected starter failures using
the pinned Lean 4.28.0. Success ends with `BROWSER_WORKSHOP_OK`.
The Lean toolchain must be installed in advance for offline use.

To check your own saved file, run `./workshop browser check PATH/TO/FILE.lean`.
Use `./workshop help` for available commands. Repository contributors can use
`./workshop check` for the full local checks; see
[CONTRIBUTING.md](CONTRIBUTING.md) and [AGENTS.md](AGENTS.md).
