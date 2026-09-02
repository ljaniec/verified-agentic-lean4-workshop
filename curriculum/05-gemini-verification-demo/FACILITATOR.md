# Facilitator Notes — Stage 05

**Status: not frozen until the Gemini/agent integration passes an end-to-end
rehearsal on the event environment.**

This file defines acceptance criteria for the final demo; it is not yet an API
answer key.

## Required visible sequence

```text
1. Gemini produces a candidate.
2. The candidate crosses a constrained tool boundary.
3. Lean rejects the prepared first candidate.
4. The real Lean diagnostic is visible.
5. The diagnostic is returned to the model or explained in the fallback.
6. A repaired candidate crosses the same checker.
7. Lean accepts.
```

## Freeze before the event

Record here once tested:

- exact Gemini model identifier;
- authentication path;
- exact ADK/tool command;
- theorem selected for the demo;
- one tested invalid candidate;
- expected Lean diagnostic;
- one tested repaired candidate;
- expected successful checker result;
- network/offline fallback sequence.

## Deterministic fallback

Prepare known-invalid and repaired Lean snippets and run both through the same
constrained checker. The fallback must still demonstrate proposal → rejection →
feedback → repair → verification.

The audience should leave knowing that the language model is not authorized to
certify its own output.
