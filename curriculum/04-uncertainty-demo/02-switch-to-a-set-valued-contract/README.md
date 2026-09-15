# Demo 04.2 — Switch to a Set-Valued Contract

**Target time:** 2 minutes

## Facilitator action

Show the small executable policy that receives two intervals:

```text
path interval
obstacle uncertainty interval
```

It returns `ACCEPT` only when the intervals are separated; otherwise it returns
a fallback/replan decision.

Compare two examples:

```text
path [0, 4], obstacle [7, 10]  → ACCEPT
path [0, 8], obstacle [6, 10]  → FALLBACK
```

## Ask the room

Which component is responsible for the meaning of the uncertainty set?

The planner contract assumes that perception provides a set with the promised
coverage/semantics. Formal verification of the planner does not magically
validate an incorrect perception guarantee.

## Generalization

The interval is intentionally simple. The same logical interface can later use:

- boxes;
- polytopes;
- reachable sets;
- conformal prediction sets;
- other certified uncertainty regions.

## Done when

Participants can state the contract as "accept only if every obstacle position
allowed by perception is separated from the planned path."
