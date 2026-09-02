# Facilitator Notes — Stage 04

Use the reference checkout:

```bash
./workshop scenario solution uncertainty
./workshop scenario check
```

## Prepared examples

Safe separation:

```text
path       [0, 4]
obstacle   [7, 10]
set-aware decision → ACCEPT
```

Misleading point estimate:

```text
path                  [0, 8]
point estimate         10
uncertainty interval   [6, 10]
point-estimate policy  → ACCEPT
set-aware policy       → FALLBACK
```

## Lean result to show

The main theorem proves that when the set-aware planner accepts, every point in
the path interval differs from every point admitted by the obstacle uncertainty
interval.

The proof obtains the interval-separation fact from `decidePlan = .accept` and
uses integer arithmetic (`omega`) in the two possible separation directions.

## Presentation order

1. Show only the point estimate and ask for the planner decision.
2. Reveal the uncertainty interval.
3. Run both executable policies.
4. Show the universal Lean contract.
5. Separate planner correctness from the assumption that perception supplied a
   valid uncertainty set.

## Do not claim

This is not a complete collision-avoidance or perception-safety proof. The
one-dimensional interval is a compact vehicle for the contract structure.
