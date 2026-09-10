# Architecture and Trust Boundary

The workshop separates candidate generation from verification:

```text
participant
    |
    v
editor / Antigravity / optional ADK tutor
    |                    |
    |                    +--> Gemini: reasoning, explanation, repair
    |                    +--> Lean Copilot: local proof suggestions
    v
participant source under playground/current/
    |
    v
constrained verification tools
    |
    +--> static workshop guard
    +--> pinned Lean 4.28 + Mathlib 4.28 environment
    v
Lean elaborator + kernel
    |
    v
verified or rejected formal claim
```

No language model is part of the trusted proof boundary. Models may produce
useful candidates, but the workshop reports a Lean result as `verified` only
after the exact source file passes the repository guard and Lean exits
successfully under the pinned project toolchain.

## Constrained agent view

The optional ADK tutor receives no general terminal or arbitrary shell tool. It
may inspect `.lean` files only under:

```text
playground/
VerifiedAgenticWorkshop/Scenarios/
VerifiedAgenticWorkshop/Workshop/   # reserved for checked workshop helpers
```

It may then ask the local checker to scan/compile one allowed Lean file.
Allowing read access to `VerifiedAgenticWorkshop/Scenarios/` is necessary: the
participant file imports those shared definitions, and a proof assistant cannot
reason reliably about a theorem while being unable to inspect the definitions
it mentions.

The agent does not receive a write tool in the current prototype. The
participant remains the source-code editor, making the distinction between an
AI proposal and the checked repository state visible.

## What the verifier does and does not establish

Lean checks the formal theorem about the workshop model. It does not magically
prove that the abstraction exactly represents every detail of a physical robot,
ROS 2 implementation, BehaviorTree.CPP runtime, VDA 5050 deployment, or motion
planner. Those model-to-system assumptions are part of the engineering claim
boundary and are stated explicitly in each scenario.

The workshop therefore teaches two separate questions:

```text
1. Is the theorem true of the formal model?
2. Is the formal model the right abstraction of the system we care about?
```

The first question is discharged by Lean. The second remains a specification
and modeling responsibility.
