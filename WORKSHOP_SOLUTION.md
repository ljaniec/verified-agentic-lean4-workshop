# Task 01 Solution

The deactivation transition releases all active resources:

```python
return State(Mode.INACTIVE, False, False, False)
```

The Lean proof performs exhaustive symbolic case analysis over the deliberately
small state/event model and lets `simp` use the `Safe` hypothesis.

This branch is the parent checkpoint of `workshop/02-bt-refinement`.
