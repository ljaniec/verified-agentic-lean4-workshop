# Task 03 Solution

The stale update trace is fully concrete, so Lean can decide the monitor result
directly:

```lean
by decide
```

The important result is not the tactic; it is the distinction between a valid
individual message and an invalid temporal trace.

This branch is the parent checkpoint of `workshop/04-uncertainty`.
