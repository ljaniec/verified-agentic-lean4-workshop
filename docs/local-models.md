# Optional Local Models

Lean Copilot is the default local model integration because it already provides
Lean-native tactic generation, proof search, and premise selection.

A larger external model can be added later as an escalation service, but it
should not replace the local verification gate. Suitable experiments include:

- a compact Lean-specialized model on participant laptops;
- a coding model used to explain compiler diagnostics;
- a large Lean-specialized model hosted on the facilitator workstation.

Use the same evaluation protocol for every backend:

- compile@1 and compile@N;
- time to first verified proof;
- number of nonexistent declarations;
- forbidden-construct attempts;
- latency and memory use;
- robustness to the pinned Mathlib version.

Do not expose a raw model server to the public Internet. Use authentication,
per-team rate limits, request-size limits, timeouts, and a bounded queue.
