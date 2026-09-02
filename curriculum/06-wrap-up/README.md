# Stage 06 — Wrap-Up

**Time:** 87–90 minutes  
**Mode:** guided discussion

## Three ideas to keep

### 1. Executable evidence and formal proof are different tools

Python is excellent for running scenarios, producing counterexamples, and
building intuition. Lean is used when the claim must quantify over the formal
state space rather than one chosen execution.

### 2. Correctness depends on the specification

Lean does not know what a robot "should" do unless we formalize that intent.
The lifecycle resource rule, BT priority order, protocol semantics, and
uncertainty-set contract all had to be stated explicitly.

### 3. AI generation and verification should be separate

Gemini, Lean Copilot, local theorem models, or future agents may all produce
useful candidates. None of them should be allowed to certify their own output.

## Workshop progression

```text
resource invariant
    ↓
behavior-preserving refactor
    ↓
temporal protocol monitor
    ↓
uncertainty contract
    ↓
AI proposal + independent verifier
```

## After the session

The participant branch intentionally contains no completed answers. A separate
`workshop/reference-solutions` branch is maintained for facilitator use and for
post-workshop study.

Recommended next topics include richer Behavior Tree semantics, versioned
industrial-protocol conformance, distributed fleet-state invariants,
uncertainty sets in higher-dimensional planning, and programmatic proof search
with LeanDojo/local models.

## Final message

> **The goal is not to make the AI infallible. It is to build a workflow that remains trustworthy when the AI is fallible.**
