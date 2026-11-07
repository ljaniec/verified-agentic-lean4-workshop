# Task 01 — Lifecycle Resource Invariant

**Timebox: 8 minutes**

## Goal

See why changing a lifecycle enum is not enough, repair the concrete transition,
and prove that the repaired transition preserves the formal resource invariant.

## Start

```bash
./workshop task start
```

This loads:

```text
playground/current/current.py
playground/current/Current.lean
```

## Work

1. In Python, repair the `ACTIVE + DEACTIVATE` branch so it releases the
   sensor, log, and actuator state.
2. Run the Python file directly if you want a fast concrete check.
3. In Lean, complete only `step_preserves_safety`.
4. Do **not** weaken `Safe` or edit the shared scenario model.

An agent may propose the proof, but it must run the checker.

## Done

```bash
./workshop task check
```

Stop at:

```text
WORKSHOP_TASK_OK 01-lifecycle
```

Then:

```bash
./workshop task next
```
