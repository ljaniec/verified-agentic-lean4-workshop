# Speaker Script — Lean 4 and Software Verification

> Earlier introduction draft. The current event uses the
> [supplied presentation](workshop-slides.pdf) and
> [agenda / task talk hints](workshop-agenda.pdf). This script does not follow
> the supplied 18-slide deck; retain it only as optional background.

This script follows the ten slides in `lean4_software_verification_15min.tex`.
It is written to be spoken almost verbatim. Keep the examples at the level given
here; the hands-on workshop will provide the details.

## Delivery rule

- Read the main paragraph for each slide.
- Use the final **transition sentence** to advance immediately.
- Do not explain unrelated Lean syntax, theorem-prover history, type theory,
  ROS 2 internals, BehaviorTree.CPP internals, or the broader research program
  unless someone asks after the workshop.
- If you are running late, omit the paragraph marked **Optional**.

---

## Slide 1 — From Hallucination to Proof

Good morning. I want to start with one practical question: if an AI agent writes
or modifies robotics software, what would make us accept the result as correct?
A confident explanation is not enough, and a plausible-looking piece of code is
not enough. In this workshop we will use Lean 4 as an independent verification
boundary. AI systems may propose implementations, invariants, and proofs, but
they do not certify their own output. The principle for the whole session is:
**AI can propose; the verifier decides what is accepted.**

**Transition:** First, let us clarify why this distinction matters particularly
now.

---

## Slide 2 — Why verification matters now

AI coding agents can already generate, refactor, and explain fairly complex
software. That is useful, but robotics is a difficult environment for plausible
code. A robotic system combines state machines, asynchronous callbacks,
sensors, logs, shared resources, communication protocols, and physical actions.
A subtle state-management error may not merely produce a bad web page; it may
change what a machine does in the world. We therefore need a clean separation
between producing a candidate and accepting that candidate. The language model
may be powerful and still be wrong. The checker should remain independent of
it.

**Scope guard:** Do not turn this into a general discussion of AI safety or all
possible robotics failures.

**Transition:** The first distinction we need is between testing and proving.

---

## Slide 3 — Testing and proving answer different questions

Testing and formal verification are complementary. A test executes selected
examples. It is excellent for finding concrete failures and for checking a real
implementation under realistic conditions. But a test normally samples only a
small part of the possible state space. A formal proof starts from a precise
mathematical claim and asks whether that claim holds for every case represented
by the model. This gives broader coverage, but only inside the model and under
its assumptions. My shorthand for the workshop is: **Python shows what happens
for concrete executions; Lean checks what must always happen in the formal
model.** We want both, not one instead of the other.

**Transition:** So what exactly does Lean check?

---

## Slide 4 — What Lean 4 checks

Lean represents a proposition as a type and a proof as a term of that type. You
do not need to understand the full type-theoretic foundation today. The
practical point is simpler. We define a state, a transition function, and a
property such as `Safe`. Then we state a theorem saying that if the current
state is safe, the next state is also safe. Tactics help us construct the proof,
but the final proof term is checked against the theorem statement. If the proof
does not establish exactly that statement, Lean rejects it. The theorem is not
accepted because the tactic looked intelligent or because an AI model sounded
confident.

**Scope guard:** Do not explain dependent type theory, Curry–Howard history, or
the Lean elaborator here.

**Transition:** This is where the small trusted kernel becomes important.

---

## Slide 5 — Why the kernel matters

A proof candidate can come from a human, Gemini, Codex, Claude, Lean Copilot, or
a small local model. All of these generators can make mistakes. They may use a
nonexistent lemma, produce invalid syntax, misunderstand the assumptions, or
simply prove something different from the requested claim. Lean's kernel is the
final checker of the resulting proof term. This gives us a useful architecture:
a strong but fallible generator remains outside a much smaller and stricter
verification boundary. We do not need the generator to be infallible. We need
its output to pass an independent check.

**Optional:** This is also why switching models does not change the trust model.
Different models can propose different candidates, while Lean applies the same
acceptance criterion to all of them.

**Transition:** However, a checked proof is not automatically a proof about the
entire physical robot.

---

## Slide 6 — What have we actually verified?

There are several layers between a physical system and a verified theorem. We
start with the real robot and its environment. We choose modelling assumptions
and build a formal state and transition model. We then decide what property to
state: an invariant, a refinement relation, or another contract. Finally, Lean
checks the proof of that property. These layers produce three separate
questions. First: is the theorem true of the model? Lean answers this very well.
Second: does the model represent the relevant part of the real system? Third:
did we formalize the requirement we actually care about? Those last two are
engineering and specification problems. Lean makes them more visible, but it
does not solve them automatically.

**Key sentence:** A formally verified answer to the wrong question is still the
wrong engineering result.

**Transition:** The lifecycle example shows this distinction with a very small
model.

---

## Slide 7 — Lifecycle state is not the whole state

Imagine a ROS 2-style managed component. Its lifecycle mode may be
`Unconfigured`, `Inactive`, or `Active`, but the application state contains more
than that enum. It may own a sensor handle, an open log, and the authority to
command an actuator. We can state an invariant: an active node must have the
required resources, and any retained runtime resource implies that the node is
active. Now consider a faulty deactivation that changes only the mode from
`Active` to `Inactive` but leaves the sensor, log, or actuator enabled. A unit
test checking only the enum can pass. The application invariant fails. In the
workshop we will repair the transition and prove that every modeled transition
preserves the invariant.

**Scope guard:** Do not explain the complete ROS 2 lifecycle standard or real
resource-acquisition APIs.

**Transition:** The next example concerns a refactor rather than one state
transition.

---

## Slide 8 — Did the refactor preserve behavior?

The reference policy is a simplified Behavior Tree. It checks cancellation
first, then success, then whether a path is available, and finally requests a
plan. A handwritten FSM rewrite accidentally checks path availability before
cancellation. Most ordinary examples still look correct. But when a cancellation
request and an available path occur together, the reference policy stops while
the rewrite drives. That one counterexample exposes an implicit priority rule.
We then repair the FSM and state a universal refinement theorem: for every
modeled observation, the corrected FSM returns the same observable decision as
the reference policy. This is a precise meaning of “the refactor preserves
behavior” for this small model.

**Scope guard:** Do not claim full equivalence with arbitrary asynchronous
Behavior Trees, blackboards, or `RUNNING` semantics.

**Transition:** AI assistance becomes useful when it operates inside this
verification loop.

---

## Slide 9 — AI-assisted verification loop

The workflow is intentionally simple. The agent reads the goal and proposes a
candidate. The repository runs the exact local checker. If Lean rejects the
candidate, we keep the real diagnostic and return it to the agent. The agent
then proposes a smaller repair, and the same checker runs again. During the
final task we will deliberately start with a wrong proof candidate, so the
rejection is guaranteed rather than staged. This demonstrates the distinction
between generation and verification. A bad proof of a good theorem can be
caught by Lean. But there is another failure mode: a good proof of a weak or
incorrect theorem may compile perfectly.

**Key sentence:** The agent is allowed to be wrong. The verification boundary
is not allowed to pretend that it succeeded.

**Transition:** That leads to the limitations we should state explicitly.

---

## Slide 10 — What formal verification gives us

Formal verification gives strong guarantees for explicit claims under explicit
definitions and assumptions. It can expose regressions, missing cases,
inconsistent state, and false universal claims. It does not automatically prove
that our sensor model is accurate, that timing assumptions hold, that every
physical effect is represented, or that our natural-language requirement was
translated correctly. The practical goal is therefore not to claim that the
whole robot is “formally verified.” It is to build small, explicit,
independently checked contracts at important software boundaries. AI can help
us formulate, implement, and repair those contracts, but it should not certify
itself.

We will now apply this pattern directly. The repository will give us a concrete
execution, a formal claim, an agent proposal, and a local verification result.

**Final transition:** Let us start with the lifecycle resource invariant.

---

# One-page presenter guardrail

Use these sentences if you feel yourself drifting:

1. **AI motivation:** “The issue is not whether the model is useful; it is who
   decides that its output is correct.”
2. **Testing:** “Tests cover executions we run; a proof covers the cases in the
   formal model.”
3. **Lean:** “Tactics and LLMs construct candidates; the kernel checks them.”
4. **Limitations:** “Proof correctness and model adequacy are different
   questions.”
5. **Lifecycle:** “The enum changed, but the resources did not.”
6. **BT refinement:** “The counterexample exposes a priority regression.”
7. **Agent loop:** “Use the diagnostic, repair the candidate, run the same
   checker again.”
8. **Conclusion:** “Small verified contracts, not universal claims about the
   whole physical system.”
