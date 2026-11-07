# Task 03 — Temporal Trace Conformance

**Timebox: 6 minutes**

## Goal

See why individually valid messages can still form an invalid protocol trace,
then make Lean certify the exact temporal diagnostic.

## Start

```bash
./workshop task start
```

The Python monitor is already complete on this checkpoint. Run it once and read
the first rejected-event diagnostics.

## Work

In Lean, complete only:

```text
stale_update_diagnostic
```

The trace is concrete and decidable. Do not expand this into a full VDA 5050
formalization.

## Claim boundary

This proves one temporal rule in a teaching profile. It is **not** VDA 5050
certification.

## Done

```bash
./workshop task check
```

Stop at `WORKSHOP_TASK_OK 03-vda-trace`, then run
`./workshop task next`.
