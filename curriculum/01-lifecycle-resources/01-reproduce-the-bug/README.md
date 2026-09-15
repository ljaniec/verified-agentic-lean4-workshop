# Task 01.1 — Reproduce the Bug

**Target time:** 3 minutes

## Objective

See the concrete failure before trying to prove anything.

## Inspect

Open `playground/current/current.py` and find:

- `ACTIVE_STATE`;
- `buggy_step`;
- `safe`.

The deliberately faulty `DEACTIVATE` case changes the lifecycle mode but keeps
the old resource flags.

## Run

You may use the starter's existing assertion or inspect the expression in a
Python REPL:

```python
buggy = buggy_step(ACTIVE_STATE, Event.DEACTIVATE)
print(buggy)
print(safe(buggy))
```

## Expected observation

The resulting state is inactive while runtime resources remain held. The safety
predicate should reject it.

## Question

Why would a unit test that checks only `state.mode is Mode.INACTIVE` miss this
bug?

## Done when

You can name at least one piece of application state that remains inconsistent
after the buggy transition.

## Hint

The lifecycle enum is only one field of `State`.
