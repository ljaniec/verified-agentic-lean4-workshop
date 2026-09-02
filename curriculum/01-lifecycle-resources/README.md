# Stage 01 — Lifecycle Resources

**Time:** 10–30 minutes  
**Mode:** participant exercise  
**Scenario:** `lifecycle`

A ROS 2-style lifecycle mode is not the complete application state. The node
also owns a sensor handle, a log resource, and actuator authority. The exercise
starts with a deliberately faulty deactivation that changes the lifecycle mode
but leaves runtime resources active.

## Tasks

1. [`01-reproduce-the-bug`](01-reproduce-the-bug/README.md)
2. [`02-read-the-invariant`](02-read-the-invariant/README.md)
3. [`03-repair-the-python-transition`](03-repair-the-python-transition/README.md)
4. [`04-check-the-finite-state-space`](04-check-the-finite-state-space/README.md)
5. [`05-prove-one-step-preservation`](05-prove-one-step-preservation/README.md)
6. [`06-lift-to-finite-traces`](06-lift-to-finite-traces/README.md) — stretch task

## Files

```text
playground/current/current.py
playground/current/Current.lean
```

Start or reset this stage with:

```bash
./workshop scenario start lifecycle
```

## Minimum completion target

If time is tight, finish Tasks 01–05. Task 06 is a useful induction exercise but
may be skipped before the main Behavior Tree exercise.
