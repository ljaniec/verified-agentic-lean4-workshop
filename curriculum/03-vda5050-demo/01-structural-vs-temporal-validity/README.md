# Demo 03.1 — Structural Validity Is Not Temporal Validity

**Target time:** 2 minutes

## Facilitator action

Show a short trace in which each message is individually representable by the
model but the sequence violates the monitor's temporal policy.

A representative stale-update shape is:

```text
order(orderId=7, orderUpdateId=0)
order(orderId=7, orderUpdateId=0)
```

## Ask the room

- Is either message malformed by itself?
- What information is missing if we validate each message independently?
- Which state must a temporal monitor remember between messages?

## Key observation

```text
message validity
    ≠
trace conformance
```

The monitor carries state across the trace, including the active order/update
and progress information.

## Claim boundary

Do not describe this as full VDA 5050 certification. The purpose is to expose
the difference between structural validation and behavioral/temporal rules.

## Done when

Participants can explain why JSON-schema validation alone cannot express every
cross-message protocol requirement.
