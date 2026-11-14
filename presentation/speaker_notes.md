# From Hallucination to Proof — Speaker Notes

**Current 18-slide deck · 14 November 2026 · Presented by Mariusz Pawlus**

Use with `workshop-slides.pdf` and `workshop-agenda.pdf`. Print the companion
`speaker_notes.pdf` on A4, actual size. These notes follow the slide order exactly.
Slides 1–9 are the introduction. Start the **45-minute practical timer on slide 10**;
slides 10–11 together are Task 00. Do not add a second setup slot.

**Practical stops:** Task 00 → 4:00 · 01 → 12:00 · 02 → 23:00 · 03 → 29:00 ·
04 → 35:00 · 05 → 42:00 · wrap-up → 45:00.

## Slide 1 — From Hallucination to Proof

“Today we will connect a fast, fallible proposer to an independent checker.
An AI assistant can suggest code, requirements, and proofs. Our question is:
what evidence lets us accept the result? We will use small robotics examples
and Lean 4 to make that acceptance boundary visible.”

**Transition:** “Why does this matter when AI changes software?”

## Slide 2 — Why this matters now

“Agents can already generate and refactor substantial software. In robotics,
software decisions can become physical actions. Plausible code and passing
examples are useful, but they do not establish that a property holds in every
modeled execution. The agent is allowed to be wrong; the verification boundary
must not pretend that it succeeded.”

**Point to:** proposer → software → physical system. **Transition:** “Testing
and proving give us different kinds of evidence.”

## Slide 3 — Testing and verification answer different questions

“A test checks executions we choose to run. It is excellent for finding a
counterexample. A theorem covers every value admitted by its formal model,
under stated assumptions. Here the assumption says the starting state is safe;
the conclusion says the next state is safe. We need both concrete executions
and explicit contracts.”

**Avoid:** claiming that every execution of the real robot has been covered.
**Transition:** “What makes Lean a checker of that contract?”

## Slide 4 — Lean 4 in one slide

“A theorem is a proposition represented as a type. A proof is a term of that
type. Tactics help construct the term; the kernel checks it. Mathlib supplies
reusable mathematics, though today's paste-ready tasks need only Lean's standard
library. An accepted proof establishes the exact statement, not an AI's explanation.”

**Avoid:** a tactic catalog or type-theory detour. **Transition:** “There are
still engineering decisions outside the proof.”

## Slide 5 — The three layers of correctness

“Separate the real system, the model we chose, and the requirement we expressed
as a formal claim. Lean checks whether the proof establishes that claim from
those definitions and assumptions. Engineers still have to justify that the
model and requirement are right. A correct proof of the wrong theorem is still
the wrong engineering result.”

**Transition:** “The lifecycle example makes this concrete.”

<!-- pagebreak -->

# Introduction continued — slides 6–10

## Slide 6 — Running example: lifecycle resources

“Changing the lifecycle enum is not enough. The application also owns sensor,
log, and actuator resources. Open resources require active mode, and active mode
requires the sensor and log. A faulty deactivation can change the mode while
retaining resources. A test that checks only the mode misses the broken invariant.”

**Point to:** the inactive state with retained handles. **Transition:** “A
refactor can introduce a different kind of bug: a changed priority.”

## Slide 7 — Refactoring behavior, not syntax

“The reference Behavior Tree checks cancellation before success or an available
path. A handwritten FSM checks path availability too early. When cancellation
and a path are both present, the BT stops but the buggy FSM drives. Our contract
will be equality of the observable decision for every modeled observation.”

**Avoid:** full asynchronous Behavior Tree semantics. **Transition:** “Every
proposer will face the same acceptance gate.”

## Slide 8 — AI-assisted verification: one gate for every proposer

“A human, Gemini, Codex, Claude, or a local model may propose a candidate.
Lean either accepts that exact proof or returns a diagnostic for repair.
The model is outside the proof authority. In the repository, agent instructions
keep the definitions and theorem fixed and prohibit proof bypasses.”

**Clarify:** the slide's `./workshop task check` is the older local route.
For this browser workshop, use Lean Web's **All Messages**. The current offline
command is `./workshop browser check`.

**Transition:** “Before trying it, let us be precise about the limits.”

## Slide 9 — What we are not claiming

“Lifecycle preservation is about our resource model, not the whole ROS 2 runtime
or physical shutdown. BT refinement is about simplified decisions, not arbitrary
concurrent trees. The trace monitor is a teaching profile, not VDA 5050
certification. The uncertainty contract is relative to the supplied set;
justifying that the set contains the real obstacle is a separate obligation.”

**Transition:** “Now we will check the actual examples.”

## Slide 10 — Workshop setup: use Lean in the browser

**START THE 45-MINUTE PRACTICAL TIMER NOW. Task 00 ends at 4:00.**

“We are using Lean in the browser so nobody spends workshop time installing a
toolchain. Open `https://live.lean-lang.org/`, paste the entire self-contained
task, and edit only the final proof after `:= by`. Read the exact diagnostic.
Accept the candidate only after checking has finished with no errors or warnings.”

**Show:** the QR, the published README, Task 00's **Raw** file, and the editor.
Replace the previous editor contents each time. Keep **All Messages** expanded.
The files need only `import Std`; no account, API key, or model setup is needed.

**Transition:** “The proposer offers a candidate. The checker decides.”

<!-- pagebreak -->

# Hands-on work — slides 11–13

## Slide 11 — Task 00: the verification gate

**0:00–4:00 overall · maximum explanation: 45 seconds.**

“The model, developer, and local agent are all proposers. None certifies its
own result. The exact Lean checker is the acceptance boundary.”

**Show:** Task 00 accepts `n + 0 = n` with `rfl`. Temporarily change the right
side to `n + 1`, observe rejection, and restore it. Point to the candidate arrow
and the outside feedback arrow. No `sorry`, `admit`, invented assumptions, or
‘looks correct’ verdict. The following tasks keep their statements fixed.

**Transition:** “Now we will see why changing one state enum is not enough
to make a robotics transition safe.” **HARD STOP: move on at 4:00.**

## Slide 12 — Task 01: resource-aware lifecycle invariants

**4:00–12:00 · 60 seconds before work; 45 seconds for the solution.**

“The bug is not that the mode failed to change. The mode changes correctly,
but the sensor and log handles remain open in an inactive state.”

**Show:** the buggy Python line, then the repaired line that sets all resource
flags to `False`. In the Lean snippet, the repaired `step` is already supplied.
Participants prove that it preserves `Safe`, assuming the starting state is safe.
Four modes, eight Boolean flag combinations, and six events give **192 modeled
state/event combinations**; the safety assumption rules out unsafe inputs.

**When showing the solution, say one sentence:** “The case splits enumerate
the finite model; simplification closes the resulting goals.”

```lean
rcases s with ⟨m, sensor, log, act⟩
cases m <;> cases sensor <;> cases log <;> cases act <;> cases e <;>
  simp [Safe, step, initial, activeState] at h ⊢
```

**Transition:** “The next problem is a behavior-changing refactor.”
**HARD STOP: 12:00, even if some proofs are unfinished.**

## Slide 13 — Task 02: Behavior Tree to FSM refinement

**12:00–23:00 · 75 seconds before work; 60 seconds for the solution.**

“This is a priority regression. The reference checks cancellation before path
availability; the buggy FSM reverses that order.” Use `cancelRequested = true`,
`goalReached = false`, `pathAvailable = true`: the BT stops; the buggy FSM drives.

**Claim:** the supplied corrected FSM and reference BT return the same observable
decision for all **eight** Boolean observations. Participants prove this equality.

```lean
cases obs.cancelRequested <;> cases obs.goalReached <;>
  cases obs.pathAvailable <;> rfl
```

Say “three Boolean case splits, then reflexivity”; do not narrate all eight cases.
**Transition:** “Well-typed decisions can still form an invalid sequence.”
**HARD STOP: 23:00. This is the easiest place to overrun.**

<!-- pagebreak -->

# Demonstrations and repair — slides 14–16

## Slide 14 — Task 03: beyond schema validation — temporal traces

**23:00–29:00 · maximum explanation: 45 seconds total.**

“A schema validates one message. A temporal monitor validates how messages
evolve over time. Both update-zero messages are individually well formed,
but the second one is stale.”

**Show:** `Order(7,0)` followed by `Order(7,0)`. The exact result is
`.error .orderUpdateNotIncreasing`. Replace the final `skip` with `decide` and
show **No messages**. This proves the diagnostic for this concrete trace.

**Boundary:** a teaching profile, not full VDA 5050 certification.
**Transition:** “Next we move from temporal to geometric uncertainty.”
**HARD STOP: 29:00.**

## Slide 15 — Task 04: point estimates versus uncertainty sets

**29:00–35:00 · maximum explanation: 45 seconds total.**

“The point estimate at ten is outside the path, so the weak planner accepts.
The uncertainty interval overlaps the path between six and eight, so the
set-aware planner falls back.”

**Show the picture first:** path `[0,8]`; point estimate `10`; obstacle interval
`[6,10]`. Then show the theorem and use `decide` to check both concrete decisions.
Do not describe this example as a universal planner-safety theorem.

**Critical limit:** “Lean proves the decision relative to the supplied uncertainty
set. It does not prove that perception actually enclosed the real obstacle.”

**Transition:** “Finally, we will give Lean a bad proposal and repair it using
the real diagnostic.” **HARD STOP: 35:00.**

## Slide 16 — Task 05: proposal, rejection, and repair

**35:00–42:00 · maximum explanation: 60 seconds total.**

“The first candidate is intentionally wrong. Rejection is the feature we want
to expose.” Paste the Task 05 starter with `rfl` and read the actual error:
**Expected the goal to be a binary relation.** The goal is `Safe (...)`,
so reflexivity does not prove it.

Give the diagnostic to an assistant, or propose the repair yourself. Keep the
statement and definitions fixed; replace only the final proof with `decide`.
Wait for **No goals** and **No messages** before calling the file accepted.

```lean
theorem deactivation_from_active_is_safe :
    Safe (step activeState .deactivate) := by
  decide
```

**Emphasize:** any human or model uses the same gate. If the model is slow or
unavailable, use this deterministic sequence immediately.

**Transition:** “The value is a fast proposer connected to a verifier that can
say no.” **HARD STOP: finish by 42:00.**

<!-- pagebreak -->

# Close and recovery — slides 17–18

## Slide 17 — What the workshop establishes — and what it does not

**42:00–45:00 · maximum: three minutes including the close.**

“We verified explicit properties of explicit models. Lean gives a strong answer
to: does this theorem follow from these definitions and assumptions? Engineers
still have to justify that the model matches the system and that the theorem
expresses the right requirement. AI is the high-velocity proposer; Lean is the
strict verifier.”

Lifecycle and BT tasks prove universal claims inside their finite models.
The trace and uncertainty tasks prove the concrete examples displayed.
Sensor coverage, scheduling, networking, and physical-system fidelity remain
engineering obligations. Do not expand the demonstrated claims during wrap-up.

**Final sentence:** “A formally checked answer to the wrong question is still
the wrong engineering result.”

## Slide 18 — Thank you

“Thank you. We can take questions after the practical sequence.”
Point to `machinekind.ai/links/` if participants want the community links.
**HARD STOP: 45:00. Do not introduce another topic.**

## Emergency cut list

If two minutes behind, stop explaining implementation details. Show the result,
state its boundary, and move to the next task. Cut in this order:

1. Do not explain the internals of `rcases`, `cases`, `simp`, `rfl`, or `decide`.
2. Show Tasks 03 and 04 as presenter demonstrations.
3. State Task 02's eight-case result instead of waiting for everyone.

## Presenter fallback

**Browser unavailable:** project the local files and run `./workshop browser check`.
The pinned Lean toolchain must already be installed; no project packages or
credentials are needed for the browser bundle. For a copied edited file, run
`./workshop browser check playground/current/Current.lean`.

**Participant falls behind:** save their text and paste the next complete starter.
The tasks are independent. Do not wait for a stretch proof or download models.

**Model unavailable:** show Task 05's known `rfl` rejection and `decide` repair.
The checker result, not the identity of the proposer, is the point.

## Last check before speaking

- Open the current slides, agenda, and the published browser task guide.
- Use the repaired QR on slide 10 and the outside feedback arrow on slide 11.
- Keep Lean Web's All Messages panel open and wait for checking to finish.
- Keep the timer visible; start it on slide 10 and stop at 45:00.
