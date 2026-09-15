# Task 02.5 — Lift Refinement to Observable Traces

**Target time:** 3–5 minutes  
**Mode:** stretch task

## Objective

Show how a pointwise behavioral-equivalence theorem induces equality of finite
observable decision traces without making the optional proof block the main
workshop path.

## Before you start

The baseline starter intentionally does **not** predeclare this theorem. After
Tasks 02.1–02.4 are complete, `./workshop scenario check` should already pass.
Continue here only if time remains.

## Add this theorem

Insert the following declaration before the final namespace `end` in
`playground/current/Current.lean`:

```lean
theorem corrected_fsm_trace_matches_bt (observations : List Observation) :
    decisionTrace fsmDecision observations =
      decisionTrace btDecision observations := by
  -- prove the stretch theorem here
```

## Idea

If both implementations make the same decision for every observation, mapping
either implementation over the same finite observation list should produce the
same decision list.

```text
pointwise equivalence
    ⇒
finite trace equivalence
```

Possible approaches include:

- induction over the observation list;
- simplifying the mapped-list equality using `corrected_fsm_matches_bt`.

## Why this matters

A real refactoring contract is usually about externally observable executions,
not just source-code structure. This small theorem is the workshop's bridge
toward trace refinement, simulation relations, and richer behavioral semantics.

## Check

If you add the theorem, run:

```bash
./workshop scenario check
```

## Done when

Either the trace theorem compiles, or you can explain why pointwise equality is
sufficient for this deliberately stateless teaching model.

## Recovery / falling behind

Move to the demos when the facilitator calls time. If your optional theorem is
unfinished, preserve the attempt in your editor or backup and remove the
incomplete addition if you want to retain a clean baseline scenario. Starting
the next scenario automatically backs up the current pair.
