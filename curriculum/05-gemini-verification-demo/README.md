# Stage 05 — Gemini-Assisted Verification Loop

**Time:** 76–87 minutes  
**Mode:** facilitator demo; optional participant interaction  
**Status:** integration under active development

This is the Google-facing finale. The intended demo is not "Gemini knows Lean".
It is a controlled loop in which Gemini may propose an incorrect candidate and
an independent verifier decides whether it is accepted.

## Demo steps

1. [`01-make-the-tool-boundary-visible`](01-make-the-tool-boundary-visible/README.md)
2. [`02-submit-a-candidate-and-observe-rejection`](02-submit-a-candidate-and-observe-rejection/README.md)
3. [`03-repair-and-verify`](03-repair-and-verify/README.md)

## Intended architecture

```text
Gemini proposal
    ↓
constrained tool call
    ↓
Lean checker
    ↓
compiler/verifier result
    ↓
Gemini explanation or repair
```

The model must never be able to declare its own candidate verified without a
successful checker result.

## Event-readiness rule

The live cloud/agent path is used only after it has been tested end to end on
the exact workshop environment. Until then, this stage has a deterministic
fallback: the facilitator manually shows a prepared invalid candidate, runs the
same local Lean checker, then applies a prepared repaired candidate.

The conceptual lesson therefore does not depend on network availability or an
unfinished API integration.
