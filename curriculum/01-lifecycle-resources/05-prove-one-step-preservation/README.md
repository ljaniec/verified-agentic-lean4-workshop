# Task 01.5 — Prove One-Step Preservation in Lean

**Target time:** 5 minutes

## Objective

Move from executable checking to a universal proof obligation.

## Edit

Open:

```text
playground/current/Current.lean
```

Complete the theorem stating that a safe state remains safe after one repaired
lifecycle event.

The theorem has the shape:

```text
Safe state → Safe (step state event)
```

for arbitrary `state` and `event`.

## Suggested proof strategy

This state space is intentionally small. A direct case split is pedagogically
useful because it lets Lean expose which combinations are impossible under the
`Safe` hypothesis.

Useful ingredients include:

```lean
rcases
cases
simp
```

You may also ask Lean Copilot for a candidate tactic sequence, but compile the
result before trusting it.

## Check

```bash
./workshop scenario check
```

## Done when

The one-step preservation theorem compiles without proof bypasses.

## Recovery without the answer

If you are stuck after two minutes:

1. destruct `state` into its fields;
2. case-split the lifecycle mode and event;
3. let `simp` use both the safety hypothesis and transition definitions;
4. ask the facilitator for the next tactic category, not the completed proof.

The workshop should move on even if your final proof is not yet as compact as
the facilitator's reference proof.
