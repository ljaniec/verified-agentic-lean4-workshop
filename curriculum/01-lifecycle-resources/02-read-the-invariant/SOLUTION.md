# Solution Note — Task 01.2

The intended invariant is the conjunction of five ideas:

```text
Active → sensorOpen ∧ logOpen
sensorOpen → Active
logOpen → Active
actuatorEnabled → Active
Unconfigured ∨ Finalized → all runtime resources are false
```

Therefore the example states classify as:

```text
Inactive, false, false, false  → safe
Inactive, true,  true,  false  → unsafe
Active,   true,  true,  true   → safe
Active,   false, true,  false  → unsafe
```

The second and fourth cases are useful for explaining why the implications are
not redundant.
