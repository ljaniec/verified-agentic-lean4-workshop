# Solution Note — Task 02.5

Because the teaching model is stateless at the observation level, its decision
trace is just a map of the policy over a list. Pointwise equivalence rewrites
the complete trace directly:

```lean
theorem corrected_fsm_trace_matches_bt (observations : List Observation) :
    decisionTrace fsmDecision observations =
      decisionTrace btDecision observations := by
  simp [decisionTrace, corrected_fsm_matches_bt]
```

Richer asynchronous/stateful BT semantics would generally require a stronger
simulation or refinement relation.
