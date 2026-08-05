# Architecture and Trust Boundary

```text
participant
    |
    v
Antigravity / editor / ADK tutor
    |              |
    |              +--> Gemini: planning, explanation, repair
    |              +--> Lean Copilot: local tactic and premise suggestions
    v
constrained Lean tools
    |
    +--> static forbidden-construct scan
    +--> pinned Lean 4.28 + Mathlib 4.28 compiler
    v
verified or rejected result
```

No language model is part of the trusted computing base. Models may produce
useful candidates, but the repository reports `verified` only after Lean exits
successfully for the exact source file.

The ADK agent is deliberately not given a general terminal. Its tools can list,
read, scan, and compile `.lean` files only inside `playground/` and the workshop
module directory.
