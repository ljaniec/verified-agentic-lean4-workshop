# Stage 02 — Behavior Tree to Handwritten FSM Refinement

**Time:** 30–62 minutes  
**Mode:** main participant exercise  
**Scenario:** `bt`

This is the central workshop exercise. A simplified Behavior Tree is treated as
the reference behavior. A handwritten replacement contains a realistic
priority bug: it may drive after cancellation because it checks path availability
before the cancel request.

## Tasks

1. [`01-read-the-reference-policy`](01-read-the-reference-policy/README.md)
2. [`02-find-the-counterexample`](02-find-the-counterexample/README.md)
3. [`03-repair-the-fsm`](03-repair-the-fsm/README.md)
4. [`04-prove-pointwise-refinement`](04-prove-pointwise-refinement/README.md)
5. [`05-lift-refinement-to-traces`](05-lift-refinement-to-traces/README.md) — stretch task

Start the stage with:

```bash
./workshop scenario start bt
```

## Minimum completion target

The essential path is Tasks 01–04. Task 05 shows how a local equivalence result
lifts to a finite observable trace and may be skipped if the group needs to
catch up before the demos.
