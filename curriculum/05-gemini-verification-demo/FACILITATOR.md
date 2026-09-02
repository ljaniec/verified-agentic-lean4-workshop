# Facilitator Notes — Stage 05

**Status: not frozen until the Gemini/agent integration passes an end-to-end
rehearsal on the event environment.**

Do not treat this file as an API answer key yet. It defines the acceptance
criteria for the final demo.

## Required visible sequence

```text
1. Gemini produces a candidate.
2. The candidate is submitted through a constrained tool boundary.
3. Lean rejects the first prepared candidate.
4. The real Lean diagnostic is visible.
5. The diagnostic is returned to the model or explained in the fallback.
6. A repaired candidate is submitted through the same checker.
7. Lean accepts.
```

## Freeze before the event

Once the Google integration is chosen, record here:

- exact Gemini model identifier;
- exact authentication path used by participants/facilitator;
- exact ADK/tool invocation command;
- exact theorem selected for the demo;
- one tested invalid candidate;
- expected Lean diagnostic;
- one tested repaired candidate;
- expected successful checker result;
- offline/network fallback command sequence.

## Deterministic fallback

The workshop must remain teachable without cloud access. Prepare two local text
files or snippets:

```text
candidate-invalid.lean
candidate-repaired.lean
```

Run both through the same constrained Lean checker used by the agent-facing
tools. The fallback should still demonstrate proposal → rejection → feedback →
repair → verification.

## Success criterion

The audience should be able to answer this question correctly:

> Who is allowed to decide that the proof is verified?

The answer is the verification layer reporting a successful Lean check, not the
language model asserting that its output is correct.
