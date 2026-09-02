# Task 01.3 — Repair the Python Transition

**Target time:** 4 minutes

## Objective

Implement the corrected lifecycle transition before proving it in Lean.

## Edit

Open:

```text
playground/current/current.py
```

Implement the TODO in `step`.

The transition system should support the workshop events already defined in the
starter. In particular, deactivation from `ACTIVE` must leave a consistent
inactive state rather than copying active resource ownership forward.

## Constraints

Do not weaken `safe` to make the implementation pass. Repair the transition.

Keep the model intentionally small; this is not a full ROS 2 lifecycle
implementation.

## Check locally

Run the Python file directly while working:

```bash
python3 playground/current/current.py
```

The exercise may still fail because later TODOs are unfinished. Read which
assertion or `NotImplementedError` you reached.

## Done when

`step(ACTIVE_STATE, Event.DEACTIVATE)` returns an inactive state with the sensor
closed, log closed, and actuator disabled.

## Hints

1. Use `INITIAL` and `ACTIVE_STATE` where they make the transition intent clear.
2. `SHUTDOWN` and `RECOVER_FROM_ERROR` apply from more than one mode.
3. An unsupported event may leave the state unchanged in this teaching model.
