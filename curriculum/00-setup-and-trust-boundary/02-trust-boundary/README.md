# Task 00.2 — Understand the Trust Boundary

**Target time:** 6 minutes

## Objective

Understand what each layer is allowed to claim.

## The workflow

```text
human requirement
    ↓
AI suggestion / generated code
    ↓
Python execution or counterexample
    ↓
Lean compilation and proof checking
    ↓
accepted or rejected
```

An AI-generated proof is only a **candidate**. A successful Python example is
only evidence about that concrete execution. The workshop calls a formal claim
verified only when the exact Lean file passes the project checker.

## Try the checker

With the incomplete starter loaded, run:

```bash
./workshop scenario check
```

Read the first useful error rather than treating a red terminal as a failure of
the workshop.

## Think

For each statement, decide whether it is a proposal, an executable observation,
or a certificate:

1. Gemini says that a transition preserves safety.
2. Python runs one transition and prints a safe state.
3. Lean accepts a theorem stating that every valid transition preserves safety.
4. Lean Copilot suggests a tactic sequence that has not been compiled yet.

The intended classification is part of the discussion; no code change is
required.

## Done when

You can explain the sentence:

> **The agent is allowed to be wrong. The verification boundary is not.**

and can identify Lean's checked theorem as the formal certificate in this
workshop.
