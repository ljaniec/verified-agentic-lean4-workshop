# Facilitator Notes — Stage 04

Use the reference checkout:

```bash
./workshop scenario solution uncertainty
./workshop scenario check
```

Prepared examples:

```text
path [0, 4], obstacle [7, 10]
  → set-aware decision ACCEPT

path [0, 8], point estimate 10, uncertainty [6, 10]
  → point-estimate policy ACCEPT
  → set-aware policy FALLBACK
```

Recommended presentation order:

1. show only the point estimate and ask for the decision;
2. reveal the uncertainty interval;
3. run both executable policies;
4. show the universal Lean contract;
5. separate planner correctness from the assumption that perception supplied a
   valid uncertainty set.

The model is intentionally one-dimensional. It demonstrates the contract shape,
not a complete perception or motion-planning safety proof.
