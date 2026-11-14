# Browser workshop — participant task guide

After the Lean 4 introduction, follow the presenter through these six tasks.
Keep the [presentation](../../presentation/workshop-slides.pdf) available for
reference. No installation is needed during the session.

## One workflow for every task

1. Open [Lean Web](https://live.lean-lang.org/).
2. Open the linked `.lean` starter, select **Raw** on GitHub, and copy the entire
   file. Replace the previous editor contents; do not append to an earlier task.
3. Read the final theorem. Change only its proof after `:= by`, replacing `skip`
   or the deliberately bad `rfl`. Leave the definitions and statement unchanged.
4. Wait for checking to finish and read **All Messages**. Accept the file only
   when there are no errors or warnings and no proof bypasses. A quiet cursor
   position or an AI message is not evidence that the entire file passed.
5. Save a copy of your work before pasting the next task.

The definitions are included in each file, with only `import Std` required.
There are no imports from this repository, Mathlib, or Lean Copilot. The local
rehearsal uses Lean 4.28.0; the hosted editor's version is shown in its selector
and may differ. Always check your exact text in the selected editor.

`skip` is an intentional unfinished proof: Lean must report an unsolved goal.
Do not silence it with `sorry`, `admit`, invented assumptions, or an unchecked
computation mechanism. If you fall behind, save your work and paste the next
starter; it has no dependency on your earlier proof.

## Task 00 — the verification gate

**[Open starter](starters/00_VerificationGate.lean)**

Paste the file and see Lean accept `n + 0 = n` using `rfl`. Change the right side
to `n + 1` temporarily and observe rejection, then restore it. This setup task
is the only exercise that starts with a complete proof.

Takeaway: a proposer supplies a candidate; the checker accepts or rejects the
exact claim and proof. The remaining tasks keep their statements fixed.

## Task 01 — lifecycle resources

**[Open starter](starters/01_LifecycleResources.lean)**

The lifecycle mode changes, but stale resources can remain open. The slide's
Python example repairs the deactivation branch from:

```python
return State(Mode.INACTIVE, state.sensor_open, state.log_open, False)
```

to:

```python
return State(Mode.INACTIVE, False, False, False)
```

Read `Safe` and the corrected `step` in the Lean file. Any open resource
requires active mode; active mode also requires sensor and log resources.
Prove that `step` preserves `Safe` whenever the input satisfies `Safe`.

Hint: destructure `s`, split its mode and three Boolean flags, split `e`, then
simplify `Safe`, `step`, `initial`, and `activeState` in the assumption and goal.
The theorem covers 4 modes × 8 flag combinations × 6 events = **192 modeled
state/event combinations**, conditional on the input invariant.

<details>
<summary>Scheduled walkthrough / show the checkpoint</summary>

[Complete paste-ready file](checkpoints/01_LifecycleResources.lean).
Finite case splits enumerate the model; simplification closes the cases.
This is a resource invariant for the model, not a proof of physical shutdown.

</details>

## Task 02 — Behavior Tree to FSM

**[Open starter](starters/02_BehaviorTreeRefinement.lean)**

Reference priority: **cancel → goal reached → path available → request plan**.
For `cancelRequested = true`, `goalReached = false`, `pathAvailable = true`,
the reference stops but the buggy FSM drives. Compare `buggyFsmDecision` with
the already corrected `fsmDecision`. Your task is to prove the corrected policy
matches the reference for every observation.

The slide names `fsmStep` and `btStep` are aliases for the same repository
functions. Hint: split the three Boolean observations, then use `rfl`.
There are **eight** observations, not arbitrary asynchronous BT executions.

<details>
<summary>Scheduled walkthrough / show the checkpoint</summary>

[Complete paste-ready file](checkpoints/02_BehaviorTreeRefinement.lean).
The proof establishes equality of simplified observable decisions.

</details>

## Task 03 — temporal traces

**[Open starter](starters/03_TemporalTrace.lean)**

Both order messages `(7, 0)` are individually well-formed. The second update
is stale. Prove the exact monitor result:

```text
.error .orderUpdateNotIncreasing
```

Hint: this is a concrete decidable computation; try `decide`.
This teaching profile does not certify full VDA 5050 conformance.

<details>
<summary>Scheduled walkthrough / show the checkpoint</summary>

[Complete paste-ready file](checkpoints/03_TemporalTrace.lean).

</details>

## Task 04 — uncertainty contract

**[Open starter](starters/04_Uncertainty.lean)**

```text
path                 [0----------------8]
obstacle uncertainty             [6---------10]
point estimate                              10
intersection                     [6----8]
```

The point estimate at 10 lies outside the path `[0, 8]`, so the weak planner
accepts. The uncertainty interval `[6, 10]` overlaps the path, so the set-aware
planner falls back. Prove both decisions together. Hint: try `decide`.

This task checks that concrete example. A separate argument must justify that
the real obstacle lies in the supplied uncertainty interval. The task itself proves only the displayed concrete decisions.

<details>
<summary>Scheduled walkthrough / show the checkpoint</summary>

[Complete paste-ready file](checkpoints/04_Uncertainty.lean).

</details>

## Task 05 — proposal, rejection, repair

**[Open starter](starters/05_AgentRepair.lean)**

1. Paste the file with its deliberately wrong `rfl` proof.
2. Read the real diagnostic: Lean rejects `rfl` because `Safe ...` is not a
   reflexive binary-relation goal. The precise wording can vary by version.
3. Give that diagnostic and the entire snippet to any assistant, or propose
   the repair yourself. Change only the final proof.
4. Check the repaired file again. The slide's repair is `decide`.

No live model call is required. This deterministic sequence demonstrates the
same boundary when a human proposes the repair.

Suggested assistant prompt:

```text
Repair only the final Lean proof in this self-contained workshop snippet.
Keep all definitions and the theorem statement unchanged. Use the exact Lean
diagnostic below. Do not use sorry, admit, new axioms, native_decide, or other
proof bypasses. Return the candidate; only Lean can establish acceptance.
```

<details>
<summary>Scheduled walkthrough / show the checkpoint</summary>

[Complete paste-ready file](checkpoints/05_AgentRepair.lean).

</details>

## Wrap-up

We proved explicit claims about explicit models. Engineers still have to
justify the model, its assumptions, and the requirement. A formally checked
answer to the wrong question is still the wrong engineering result.

## Presenter and local fallback

[Facilitator guide](../../docs/facilitator-guide.md) ·
[rehearsal](../../docs/facilitator-rehearsal.md) ·
[offline instructions](../../docs/offline-mode.md).

```bash
./workshop browser check
./workshop browser show 01
./workshop browser show 01 --completed
```

Maintainers regenerate these files with
`python3 scripts/browser_workshop.py generate`. The checker compares the exports
with the unchanged shared models and compiles both the completed proofs and the
expected failing starters. Generated files are committed so browser participants
need no generator or checkout.
