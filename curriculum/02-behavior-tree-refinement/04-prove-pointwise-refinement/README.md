# Task 02.4 — Prove Pointwise Refinement

**Target time:** 10 minutes

## Objective

Replace finite testing of eight observations with a checked theorem about an
arbitrary observation.

## Edit

Open:

```text
playground/current/Current.lean
```

Complete the theorem stating that the corrected handwritten FSM returns the
same observable decision as the reference Behavior Tree for every observation.

The goal has the shape:

```text
∀ observation, fsmDecision observation = btDecision observation
```

or an equivalent theorem already provided in the starter.

## Suggested strategy

The observation record contains Boolean fields. Destruct the observation and
case-split the Booleans. Once all control-flow cases are explicit, simplification
should discharge the branches.

Useful ideas:

```lean
rcases observation with ⟨...⟩
cases ... <;> simp [fsmDecision, btDecision]
```

Lean Copilot or Gemini may suggest a proof, but the exact file still has to
compile.

## Check

```bash
./workshop scenario check
```

## Done when

The corrected FSM/reference equivalence theorem compiles without bypasses.

## Recovery without revealing the proof

If stuck, ask the facilitator which input fields must be case-split. The key
idea is finite symbolic case analysis, not a particular compressed tactic line.
