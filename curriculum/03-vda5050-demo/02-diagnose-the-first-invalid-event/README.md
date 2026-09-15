# Demo 03.2 — Diagnose the First Invalid Event

**Target time:** 3 minutes

## Facilitator action

Run the prepared Python reference monitor on two invalid traces:

- a stale order update;
- a regressing node-sequence report.

The solution branch exposes a detailed monitor result containing both a typed
violation and the zero-based index of the first rejected message.

## Expected style of output

```text
violation = ORDER_UPDATE_NOT_INCREASING
index     = 1
```

or:

```text
violation = NODE_SEQUENCE_REGRESSED
index     = ...
```

## Ask the room

Why is a typed diagnostic more useful than a single `False`/`None` result for:

- debugging;
- an AI repair agent;
- log analysis;
- future standards-conformance tooling?

## Key lesson

A verifier is more useful to humans and agents when rejection is accompanied by
structured evidence about **where** and **why** the trace became invalid.

## Done when

Participants can distinguish a decision procedure (`valid/invalid`) from a
useful diagnostic monitor (`invalid because X at event i`).
