# Task 02.5 — Lift Refinement to Observable Traces

**Target time:** 3–5 minutes  
**Mode:** stretch task

## Objective

Show how a pointwise behavioral-equivalence theorem induces equality of finite
observable decision traces.

## Idea

If both implementations make the same decision for every observation, mapping
either implementation over the same finite observation list should produce the
same decision list.

The theorem has the conceptual form:

```text
pointwise equivalence
    ⇒
finite trace equivalence
```

## Task

Complete the trace theorem already present in the Lean starter or derive it from
your pointwise theorem.

Possible approaches include:

- induction over the observation list;
- simplifying a `map` equality using the pointwise theorem.

## Why this matters

A real refactoring contract is usually about externally observable executions,
not just the source-code structure. This small theorem is the workshop's bridge
toward trace refinement, simulation relations, and richer behavioral semantics.

## Done when

The trace theorem compiles, or you can explain why pointwise equality suffices
for this deliberately stateless teaching model.

## Timebox

Move to the demos when the facilitator calls time. The trace result is useful,
but it is not required to understand the next stages.
