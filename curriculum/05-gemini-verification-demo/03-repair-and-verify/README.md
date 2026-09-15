# Demo 05.3 — Repair and Verify

**Target time:** 4 minutes

## Objective

Close the loop: verifier feedback becomes input to a second proposal, but Lean
still performs the final acceptance.

## Preferred live path

Return the Lean diagnostic to Gemini and ask for a repaired candidate. Submit
the repair through the same constrained checker.

## Successful ending

The final visible sequence should be:

```text
candidate 1 → rejected
Lean feedback → returned to the model
candidate 2 → checked
Lean → verified
```

Do not end on the model saying "this should work". End on the actual verifier
result.

## Optional comparison

If time remains, mention that a local theorem model or Lean Copilot could
produce a different candidate while using exactly the same verification
boundary.

The point is not which model wins. The point is that the acceptance rule does
not change with the generator.

## Fallback

Use a prepared repaired candidate and run it through the local checker. The
fallback must still show the same proposal/check/result separation.

## Final sentence

> **AI can propose, explain, and repair. The independent verifier decides what is accepted.**

## Done when

The audience has seen the entire proposal → rejection → feedback → repair →
verification loop, either live through Gemini or through the deterministic
fallback.
