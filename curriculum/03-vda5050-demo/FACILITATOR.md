# Facilitator Notes — Stage 03

Use the reference checkout:

```bash
./workshop scenario solution vda
./workshop scenario check
```

The Python reference monitor demonstrates:

```text
VALID_TRACE
  → Monitor(current_order=7, last_order_update_id=1, last_node_sequence_id=4)

STALE_UPDATE_TRACE
  → ORDER_UPDATE_NOT_INCREASING at index 1

REGRESSING_STATE_TRACE
  → NODE_SEQUENCE_REGRESSED at index 2
```

The Lean reference file checks the corresponding accepted/rejected examples and
typed diagnostics with `decide`.

## Presentation order

1. Show two individually representable messages.
2. Ask why the second becomes invalid only in context.
3. Run the detailed Python monitor and expose the first-invalid index.
4. Show the typed Lean diagnostic theorem.
5. State the scope limitation explicitly.

## Do not claim

Do not call this a complete VDA 5050 implementation or certification tool. It
is a small temporal-conformance teaching profile inspired by the standard.
