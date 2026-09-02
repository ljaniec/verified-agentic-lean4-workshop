# Solution Note — Task 02.1

The reference priority is:

```text
1. cancel requested  → STOP_AND_CANCEL
2. goal reached      → REPORT_SUCCESS
3. path available    → DRIVE
4. otherwise         → REQUEST_PLAN
```

Therefore the four suggested observations evaluate respectively to:

```text
STOP_AND_CANCEL
REPORT_SUCCESS
DRIVE
REQUEST_PLAN
```

The workshop models the observable single-step decision, not full
BehaviorTree.CPP execution semantics.
