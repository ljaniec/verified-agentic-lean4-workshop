# Facilitator Notes — Stage 03

Use the reference checkout:

```bash
./workshop scenario solution vda
./workshop scenario check
```

Prepared outcomes:

```text
VALID_TRACE
  → Monitor(current_order=7, last_order_update_id=1, last_node_sequence_id=4)

STALE_UPDATE_TRACE
  → ORDER_UPDATE_NOT_INCREASING at index 1

REGRESSING_STATE_TRACE
  → NODE_SEQUENCE_REGRESSED at index 2
```

Recommended presentation order:

1. show two individually representable messages;
2. ask why the second becomes invalid only in context;
3. run the detailed Python monitor and show the first-invalid index;
4. show the typed Lean diagnostic theorem;
5. state the scope limitation explicitly.

This is a small VDA 5050-inspired teaching profile, not a complete conformance
or certification tool.
