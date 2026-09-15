# Demo 04.1 — Show the Point-Estimate Failure

**Target time:** 2 minutes

## Facilitator setup

Use the prepared example:

```text
planned path          = [0, 8]
point obstacle estimate = 10
certified uncertainty   = [6, 10]
```

## First decision

A planner using only the point estimate sees:

```text
10 ∉ [0, 8]
```

and may return `ACCEPT`.

## Ask the room

What information was discarded when perception was reduced to one point?

## Reveal

The uncertainty interval overlaps the path:

```text
[6, 10] ∩ [0, 8] ≠ ∅
```

so the set-aware planner must not accept.

## Key lesson

A confident-looking estimate and a safety-relevant uncertainty representation
are different interfaces.

## Done when

Participants can explain why the point estimate can be outside the path while a
possible obstacle position still lies on it.
