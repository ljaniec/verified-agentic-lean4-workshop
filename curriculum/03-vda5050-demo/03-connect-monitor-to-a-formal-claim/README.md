# Demo 03.3 — Connect the Monitor to a Formal Claim

**Target time:** 2 minutes

## Facilitator action

Show the corresponding Lean examples for the prepared traces. The point is not
to formalize the entire standard live; it is to show that the executable
monitor's behavior can itself become the subject of checked theorems.

Examples of useful claims are:

```text
validTrace is accepted
staleUpdateTrace is rejected with the expected violation
regressingStateTrace is rejected with the expected violation
```

## Ask the room

What would have to be added before this teaching monitor could support a serious
claim about a specific VDA 5050 version?

Expected answers include:

- a precisely scoped version of the standard;
- substantially more message and state semantics;
- explicit correspondence between the standard text and formal rules;
- validation against real implementations and traces.

## Key lesson

Formal verification does not make an incomplete specification complete. It
makes the claims **inside the formalized scope** precise and checkable.

## Done when

Participants understand both the value and the limitation of the demo.
