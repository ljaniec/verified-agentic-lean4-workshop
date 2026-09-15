# Demo 04.3 — Show the Universal Lean Claim

**Target time:** 3 minutes

## Facilitator action

Show the theorem checked on the reference-solutions branch. Its meaning is:

```text
if the set-aware planner accepts,
then every point on the path differs from
every obstacle position allowed by the uncertainty interval.
```

In logical form:

```text
ACCEPT
→ ∀ pathPoint obstaclePoint,
    pathPoint ∈ path
    → obstaclePoint ∈ uncertainty
    → pathPoint ≠ obstaclePoint
```

## Contrast with the Python examples

Python showed two concrete cases. Lean checks the statement for arbitrary
intervals satisfying the formal definitions.

## Ask the room

What would change in a real robot?

Likely extensions include multi-dimensional geometry, time, robot footprint,
dynamics, prediction horizon, and a precise contract describing where the
uncertainty set came from.

## Key lesson

The important idea is not the one-dimensional arithmetic. It is the interface
between an uncertain perception result and a planner that is allowed to accept
only when a universal safety condition follows.

## Done when

Participants can distinguish the formal planner guarantee from the separate
assumption that perception produced a valid uncertainty set.
