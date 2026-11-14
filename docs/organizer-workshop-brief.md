# Workshop Discussion Brief

> Optional local/extended material. For the current 45-minute event, follow
> the [browser task guide](../course/browser/README.md) and
> [supplied agenda](../presentation/workshop-agenda.pdf).

## From Hallucination to Proof: Trustworthy AI Agents with Gemini and Lean 4

**Working document for discussion with event organizers and targeted Google-tooling support**

- **Format:** 90-minute hands-on workshop
- **Presentation language:** English
- **Repository language:** English
- **Repository:** `verified-agentic-lean4-workshop`
- **Core principle:** **AI can propose; the verifier decides.**
- **Current status:** private workshop repository and draft implementation under active development

---

## 1. Purpose of this document

This document consolidates the current workshop concept and is the main starting point for discussion with the event organizers.

It also records open questions about the Google technology stack so that targeted technical advice can be requested without transferring ownership of the workshop design.

The workshop is prepared and owned end-to-end by the presenter. External support, including help from Adrian Romański, is advisory and focused primarily on using Google technologies correctly and pragmatically. The workshop content, robotics examples, Lean formalization, repository architecture, participant setup, demonstrations, and final implementation remain the presenter's responsibility.

Because the event is Google-centered, the Google technology stack should not appear as a cosmetic addition. The goal is to make **Google Antigravity, Gemini, and Google Agent Development Kit (ADK)** genuine parts of the workflow while keeping the central technical message scientifically honest:

> Generative AI can be extremely useful even when we do not blindly trust its output.

The workshop combines agentic software development with formal verification. Gemini can analyze requirements, suggest invariants, generate proof candidates, interpret compiler feedback, and repair failed attempts. ADK provides a controlled tool-use loop. Antigravity provides the developer-facing environment. Lean 4 remains the independent authority that decides whether the formal claim actually holds.

```text
human intent
    |
    v
Gemini / AI agent
    |
    | proposes code, invariants, proofs, repairs
    v
Google ADK tool orchestration
    |
    | invokes constrained verification tools
    v
Python executable model + Lean 4
    |
    | accepts or rejects
    v
verified result
```

The workshop is not intended to teach formal methods as an abstract mathematical subject. Instead, it demonstrates why formal reasoning becomes useful in ordinary robotics and cyber-physical software engineering, especially when AI agents are allowed to modify code.

---

## 2. Workshop thesis

Modern AI systems are increasingly good at:

- generating code;
- refactoring implementations;
- proposing algorithms;
- translating requirements into software;
- suggesting invariants;
- repairing compiler errors;
- using tools through agents.

However, plausible code is not the same thing as behavior-preserving code.

This difference matters especially in robotics, autonomous systems, fleet management, industrial automation, cyber-physical systems, medical devices, distributed systems, and other safety-critical software.

The workshop therefore uses a different trust model:

> **Do not require the AI model to be perfectly reliable. Put an independent verifier behind it.**

The AI may misunderstand the specification, choose the wrong lemma, generate invalid Lean, introduce a regression, or propose a false invariant. That is acceptable as long as the verification boundary remains trustworthy.

```text
proposal
    ↓
execution / counterexample
    ↓
formal verification
    ↓
compiler feedback
    ↓
AI repair
    ↓
formal verification
```

The final result is not accepted because Gemini, Lean Copilot, a local theorem-proving model, or another prover says that it is correct. It is accepted because the Lean kernel checks the proof.

Two short sentences summarize the workshop:

> **AI can propose; the verifier decides.**

> **The agent is allowed to be wrong. The verification boundary is not.**

---

## 3. Real-world motivation: fleet management and Behavior Trees

One of the strongest motivations for the workshop comes from a real robotics software-engineering experience.

The system managed a fleet of many robots. Maintaining the discrete state machines representing the state of every robot became difficult, and Behavior Trees were also used to define robot behavior.

At one point, a substantial Behavior Tree implementation written by one developer became so difficult for another developer to debug and modify that a large part of it was abandoned and rewritten as handwritten robot-state transition code.

The deeper problem was not simply “Behavior Trees versus finite-state machines.” The rewrite had no explicit machine-checked contract describing what had to remain unchanged.

Questions such as these were largely implicit:

- Does cancellation still have the same priority?
- Can a drive command still be issued after cancellation?
- Are the same terminal states reachable?
- Are resource-acquisition and release rules preserved?
- Are failure paths still equivalent?
- Which externally visible traces are allowed?
- Is the new implementation a refinement of the old one?
- Which invariants must hold for every robot in the fleet?

Instead of saying:

> “I rewrote the Behavior Tree as a state machine and it should behave the same,”

we can ask Lean to check a statement such as:

```text
for every observation:
    corrected_fsm(observation) = behavior_tree(observation)
```

or, for a richer system:

```text
observable_traces(new_implementation)
    ⊆
allowed_traces(reference_specification)
```

This story is important because it shows that formal verification is not only for advanced mathematics. It can also protect ordinary robotics software during difficult refactors.

---

## 4. Working title and abstracts

### Primary title

# From Hallucination to Proof: Trustworthy AI Agents with Gemini and Lean 4

### Possible subtitle

**Using Google Antigravity and ADK to build AI-assisted verification loops for robotics software**

### Alternative title

**AI Can Propose, the Verifier Decides: Gemini, ADK, and Lean 4 for Robotics**

### Organizer-facing abstract

AI agents are increasingly able to generate code, reason about software, and modify complex systems—but how can we know when their output is actually correct?

In this hands-on workshop, participants will build a small verification workflow for robotics software using **Google Antigravity, Gemini, and Google Agent Development Kit (ADK)** together with the Lean 4 theorem prover. Gemini will help analyze requirements, propose invariants, generate proof candidates, and repair failed attempts, while Lean acts as an independent verification boundary: AI may propose, but only the proof kernel can certify.

Using practical robotics examples, we will formally verify resource handling in a ROS 2-style lifecycle node and check whether a handwritten finite-state-machine refactoring preserves the behavior of a Behavior Tree. Short demonstrations will extend the same approach to VDA 5050-style industrial protocol conformance and perception-planning contracts under uncertainty.

No previous experience with formal methods is required.

### Shorter abstract

In this hands-on workshop, participants will use **Google Antigravity, Gemini, and Google Agent Development Kit (ADK)** to build an AI-assisted formal-verification workflow for robotics software. Gemini will propose invariants, proofs, and repairs, while Lean 4 independently checks whether those proposals are actually correct.

Through ROS 2 lifecycle and Behavior Tree refactoring examples, we will show how formal methods can catch subtle state-management and behavioral-regression bugs. Short demos will extend the approach to VDA 5050-style protocol conformance and perception-planning under uncertainty.

The central idea is simple: **AI can propose; the verifier decides.**

---

## 5. Target audience and learning objectives

The workshop should be accessible to developers who are comfortable reading code but may have no previous experience with Lean or theorem proving.

Potential participants include software engineers, AI/ML developers, robotics engineers, ROS 2 developers, students, researchers, and developers interested in cyber-physical systems or AI agents.

Useful background:

- basic programming;
- Boolean conditions and state machines;
- basic Python familiarity is helpful;
- robotics knowledge is useful but not required.

By the end of the workshop, participants should understand:

1. the difference between an AI-generated proof candidate and a kernel-checked theorem;
2. how to express a simple invariant for a robotics state machine;
3. how counterexamples expose false or incomplete specifications;
4. how to check whether a refactoring preserves observable behavior;
5. why validating individual messages differs from validating a temporal protocol trace;
6. why a point estimate from perception may be insufficient for planning;
7. how Gemini can participate in a proof-repair loop without being trusted as the final authority;
8. how ADK can constrain which tools an AI agent is allowed to execute;
9. how Lean Copilot and optional local theorem-proving models complement Gemini;
10. how the same architecture can scale toward larger cyber-physical systems.

---

## 6. Recommended 90-minute structure

We should not add another full exercise. The two main exercises are enough.

| Time | Activity |
|---:|---|
| 0–10 min | Motivation, real BT/fleet story, trust boundary |
| 10–30 min | Exercise 1: lifecycle + sensor + disk + actuator |
| 30–62 min | Exercise 2: Behavior Tree → handwritten FSM refinement |
| 62–69 min | Demo: VDA 5050-style temporal conformance |
| 69–76 min | Demo: perception-planner uncertainty contract |
| 76–87 min | Demo: Gemini + ADK agentic proof-repair loop |
| 87–90 min | Summary and directions for further exploration |

The demonstrations should be prepared so they can be shortened or skipped without breaking the two core exercises.

---

## 7. Core Exercise 1: lifecycle + sensor + disk + actuator

### Motivation

A managed node has a lifecycle state, but a real robotics application also owns physical and software resources such as a sensor handle, serial-port connection, GPU inference context, actuator interface, log file, rosbag recorder, or database connection.

A lifecycle transition may be logically valid while the application resource state is wrong.

This is a useful example because the bug initially looks mundane rather than mathematically sophisticated. That is precisely the point.

### Simplified state model

```text
Unconfigured
    |
    | configure
    v
Inactive
    |
    | activate
    | - acquire sensor
    | - open log
    | - enable actuator authority
    v
Active
    |
    | deactivate
    | - disable actuator
    | - flush/close log
    | - release sensor
    v
Inactive
```

### Example invariant

```text
Active
    → sensorOpen ∧ logOpen

sensorOpen
    → Active

logOpen
    → Active

actuatorEnabled
    → Active

Unconfigured ∨ Finalized
    → ¬sensorOpen
      ∧ ¬logOpen
      ∧ ¬actuatorEnabled
```

The bidirectional relationship between active state and runtime resource ownership is deliberate. An inactive node with an open sensor or log is considered unsafe in the workshop model.

### Deliberate bug

The buggy implementation performs:

```text
Active → Inactive
```

but forgets to disable the actuator, release the sensor, and close the log.

### Python versus Lean

Python lets participants execute concrete transitions, inspect an unsafe state, enumerate a finite state space, and see a counterexample.

Lean proves:

- the initial state is safe;
- the deliberately buggy deactivation produces an unsafe state;
- the repaired transition preserves the invariant;
- one-step preservation lifts to every finite lifecycle-event trace.

The key formal pattern is:

```text
initial state is safe
+
every transition preserves safety
=
every reachable finite trace is safe
```

---

## 8. Core Exercise 2: Behavior Tree → handwritten FSM refinement

The workshop uses a deliberately simplified Behavior Tree:

```text
Fallback [
    Sequence(cancelRequested, stopAndCancel),
    Sequence(goalReached, reportSuccess),
    Sequence(pathAvailable, drive),
    requestPlan
]
```

Cancellation has the highest priority.

The buggy handwritten state logic checks `pathAvailable` before `cancelRequested`.

Therefore:

```text
cancelRequested = true
pathAvailable   = true
```

produces:

```text
reference BT → stopAndCancel
buggy FSM    → drive
```

The reference development proves:

1. a concrete counterexample to the buggy implementation;
2. pointwise equivalence of the repaired FSM and the reference BT;
3. equality of their observable decisions over every finite observation trace.

The first workshop model intentionally omits `RUNNING`, asynchronous Behavior Tree actions, blackboard state, action cancellation internals, and concurrent subtrees. Those features are valuable future extensions, but would overload a first 90-minute workshop.

---

## 9. Demo: VDA 5050-style temporal conformance

Industrial standards are a strong example of a less obvious use of formalization.

A JSON Schema can tell us whether an individual message has the correct structure. It cannot by itself prove that an entire temporal sequence of messages represents legal behavior.

```text
structural validity
    ≠
behavioral conformance
```

The current educational profile tracks order ID, order update ID, and last reported node sequence ID. It rejects stale order updates and regressing node progress and returns typed diagnostic reasons.

This must be described as **a VDA 5050-inspired teaching profile**, not a complete VDA 5050 certification tool.

A possible future industrial direction is:

```text
VDA 5050 version
    ↓
formal behavioral model
    ↓
implementation trace
    ↓
verified conformance / counterexample
```

---

## 10. Demo: perception → planner contract under uncertainty

Suppose perception estimates an obstacle at:

```text
x = 10
```

while the planned path occupies:

```text
[0, 8]
```

A point-estimate planner may conclude:

```text
10 ∉ [0, 8]
→ ACCEPT
```

But if the perception component certifies:

```text
obstacle ∈ [6, 10]
```

then:

```text
[6, 10] ∩ [0, 8] ≠ ∅
→ FALLBACK
```

Lean proves that if the set-aware planner accepts, no path point coincides with any obstacle position allowed by the uncertainty interval.

The one-dimensional interval is intentionally small, but the logical structure scales to bounding boxes, polytopes, reachable sets, robust planning, conformal prediction sets, and uncertainty-aware collision checking.

---

## 11. Main Google technology story

The Google technologies should be part of the actual reasoning loop.

### Google Antigravity

Antigravity should be evaluated as the main developer-facing environment for the agentic portion. The important question is whether it improves the live participant workflow enough to make it recommended or required.

The useful framing is:

> “Antigravity is the environment in which an AI agent interacts with a formally checked codebase.”

### Gemini

Gemini should act as the reasoning and repair layer. Useful tasks include:

- translating an informal requirement into a candidate invariant;
- explaining why a theorem failed;
- suggesting missing cases;
- generating a proof candidate;
- comparing two implementations;
- interpreting a counterexample;
- proposing a safer implementation;
- deciding which verification tool to invoke next.

Gemini is not the final verifier.

### Google Agent Development Kit (ADK)

ADK should provide the controlled agent loop.

The agent should receive a deliberately small tool set such as:

```text
read_file
read_lean_goal
compile_lean_file
scan_for_proof_bypasses
run_python_example
```

It should not receive arbitrary shell access during the workshop.

```text
Gemini proposes proof
        ↓
ADK calls constrained Lean checker
        ↓
Lean rejects proof
        ↓
compiler result goes back to Gemini
        ↓
Gemini repairs proof
        ↓
ADK calls Lean again
        ↓
Lean accepts
```

### Gemini function calling

The application exposes constrained tool schemas. Gemini selects a permitted function and arguments, but the application executes the function. This separation is a central part of the trust model.

### Agents CLI

Agents CLI may be useful for scaffolding and testing the ADK prototype or providing a local playground. It should only appear in the participant path if it demonstrably reduces setup friction.

---

## 12. Proposed final Google demo

The final 10–12 minutes should contain the most explicit Google demonstration.

1. Open an incomplete Lean proof in Antigravity.
2. Ask Gemini to propose and verify a proof.
3. Gemini produces a plausible but invalid candidate.
4. The ADK agent invokes the constrained Lean checker.
5. Lean rejects the candidate.
6. Compiler feedback is returned to Gemini.
7. Gemini repairs the proof.
8. ADK invokes Lean again.
9. Lean accepts the corrected proof.

The lesson is:

> **The model was useful without being trusted.**

If time allows, a very short bonus can send the same theorem to Lean Copilot, a small local Lean model, and Gemini. The purpose is not benchmarking. The message is:

> **Different models may disagree. Lean does not vote.**

---

## 13. Lean Copilot

Lean Copilot remains the native Lean helper.

Useful commands include:

```lean
suggest_tactics
search_proof
select_premises
```

The intended division of labor is:

```text
Lean Copilot     → small interactive tactic suggestions
Gemini           → reasoning, explanation, repair, orchestration
local prover     → optional alternative proof candidates
Lean             → final authority
```

A project-aware premise index for the exact workshop repository is a possible future extension, not a requirement for the first event.

---

## 14. LeanDojo-v2 and local theorem models

LeanDojo-v2 should remain an optional research extension rather than a participant requirement. Possible uses include proof-state extraction, prover evaluation, custom premise retrieval, and automated proof search.

Small local theorem-proving models such as Kimina-Prover-RL-0.6B and Kimina-Prover-RL-1.7B are attractive optional demonstrations because the same Lean verifier can check candidates from local and cloud models.

A future interface may look like:

```bash
./workshop model download kimina-0.6b
./workshop model serve kimina-0.6b
./workshop dojo propose ... --model local
```

None of this should be required during the first 90-minute workshop.

---

## 15. Aristotle / Harmonic

The repository should remain compatible with Aristotle-style Lean projects. Aristotle is useful for facilitator preparation, research workflows, larger proof generation or repair, and comparison with other theorem-proving systems.

It is not necessary for participants.

The broader architecture is intentionally model-agnostic:

```text
Gemini
Lean Copilot
Kimina
Aristotle
future models
        |
        v
candidate Lean
        |
        v
same verification boundary
```

---

## 16. Repository design and participant workflow

All repository material is written in English, and the workshop itself will be delivered in English.

The project preserves a conventional Lean/Lake structure so that it remains easy to use with Lean, Mathlib, Lean Copilot, Aristotle, and later LeanDojo integration.

### Initial setup

```bash
./workshop setup
./workshop check
```

### Load an exercise

```bash
./workshop scenario start lifecycle
./workshop scenario status
./workshop scenario check
```

### Show the reference solution

```bash
./workshop scenario solution lifecycle
./workshop scenario check
```

### Validate all reference scenarios

```bash
./workshop scenario verify-solutions
```

The current scenario is placed under `playground/current/`. Before replacing current work, the loader creates a sanitized backup under `playground/backups/`.

For each scenario the repository contains an unsolved Lean exercise, unsolved Python exercise, shared Lean model, reference Lean proof, and reference Python implementation.

A useful teaching slogan is:

```text
Python:
“Show me what happens.”

Lean:
“Show me that it always happens.”
```

---

## 17. Verification and trust boundary in the repository

The repository deliberately rejects common proof bypasses and unchecked assumptions, including direct uses of constructs such as `sorry`, `admit`, `axiom`, `constant`, `sorryAx`, `native_decide`, and `implemented_by` in participant proof code.

Comments and strings are not treated as executable Lean code by the static guard. The actual Lean file is then compiled with the pinned toolchain.

The Google ADK agent follows the same rule:

```text
agent-generated text != verified proof
```

The agent may only report success after the actual Lean checker succeeds.

This static scan is a workshop guard, not a replacement for Lean's parser or kernel. The kernel remains the final proof authority.

---

## 18. No GitHub Actions

GitHub Actions are intentionally not part of this project.

Validation is local. This avoids hosted CI cost and is educationally useful because participants can see the complete verification process on their own machines.

```bash
./workshop check
```

Development and release preparation rely on local shell checks, Python tests, Lean compilation, and explicit reference-solution validation.

---

## 19. Participant setup philosophy

The workshop should minimize setup friction.

Participants should not need to understand the repository's internal scripts, Python packaging details, LeanDojo internals, model-serving configuration, ADK internals, or theorem-prover training.

The intended experience is:

```bash
git clone ...
cd verified-agentic-lean4-workshop
./workshop setup
./workshop check
```

then:

```bash
./workshop scenario start lifecycle
```

Preferred environments are Linux, macOS, and Windows through WSL 2, with Lean 4 editor support and Antigravity evaluated for the agentic portion.

Optional components must remain optional.

---

## 20. Internet and offline fallback

The workshop should not depend on perfect conference Wi-Fi.

Before the event, prepare offline copies of:

- the repository;
- Mathlib cache;
- Lean Copilot model cache;
- Python wheels;
- optional local theorem model.

Graceful degradation should look like:

```text
Full mode:
Antigravity + Gemini + ADK + Lean Copilot + Lean

No Gemini:
Lean Copilot + Lean + Python

No Lean Copilot model:
Lean + Mathlib tactics + reference solutions

No Internet:
pre-cached local environment
```

---

## 21. Gemini credentials and event support

The workshop should avoid requiring every participant to enter a credit card, manually create a cloud project during the session, copy long-lived secrets into source files, or expose API keys.

Preferred possibilities are:

1. **event-provided Gemini access or credits**;
2. **participant Google accounts with a tested onboarding flow**;
3. **facilitator-only cloud demo** if participant authentication is too costly in workshop time.

No secret should ever be committed to the repository. Local configuration should use environment variables or an ignored `.env` file.

---

## 22. Questions for organizers

### Google technology requirements

1. Is **Antigravity + Gemini + ADK** sufficient to satisfy the Google-technology requirement?
2. Is there a preference for Gemini API versus Vertex AI access?
3. Is Agents CLI expected or merely optional?
4. Is a Google Cloud deployment element expected, or is a local ADK agent sufficient?

### Credentials and credits

5. Can the event provide Gemini API credits or another approved access path?
6. Can participants receive temporary/event-scoped credentials?
7. Is there an existing DevFest/Google developer-credit process we should use?
8. What is the expected policy for participant API keys?

### Participant environment

9. Will participants bring laptops?
10. Which operating systems should be officially supported?
11. Can pre-event setup instructions be sent?
12. Can participants be asked to run a setup test before arrival?

### Network and logistics

13. How reliable is conference Wi-Fi expected to be?
14. Can the facilitator machine host a small local service if needed?
15. Are there firewall restrictions on local HTTP endpoints?
16. What is the expected participant count?
17. Is 90 minutes fixed?
18. Can participants work in pairs if useful?

---

## 23. Targeted Google-tooling support: role of Adrian Romański

Adrian's role is **targeted Google-tooling support and technical consultation**, not co-ownership of the workshop.

The presenter remains responsible for:

- the workshop concept and narrative;
- all robotics examples;
- Lean specifications and proofs;
- Python examples;
- repository implementation;
- participant setup;
- ADK integration implementation;
- demonstrations;
- testing and rehearsal;
- final presentation and delivery.

Adrian can be especially helpful as a specialist sounding board for questions such as:

- whether Antigravity is practical as a participant environment;
- which current Google agent tooling gives the lowest-friction path;
- how ADK should be structured for this small local application;
- how participants should authenticate to Gemini;
- whether the ADK playground is sufficient or a custom UI is justified;
- frontend/developer-experience pitfalls that are easy to miss;
- whether Nix or another reproducibility mechanism would materially help or merely increase complexity.

The desired interaction is therefore:

```text
presenter prepares architecture / prototype / questions
        ↓
Adrian reviews Google-specific choices and developer experience
        ↓
presenter decides and implements
```

---

## 24. Questions to ask Adrian

The highest-value questions are deliberately narrow and Google/tooling-oriented.

### Antigravity

1. Would you make Antigravity required, recommended, or facilitator-only for a 90-minute workshop?
2. What is the realistic first-run setup time for participants who have never used it?
3. Are there platform limitations that could make it unreliable on Windows/WSL, macOS, or Linux?
4. What is the simplest way to give Antigravity enough context about the repository and trust rules without building custom integration?
5. Is there an obvious feature of Antigravity we should exploit for the final “proposal → verifier → repair” demo?

### ADK and Gemini

6. Is a small ADK application with constrained Python tools the right architecture, or is there a simpler Google-native mechanism for this use case?
7. Should the ADK agent live inside the same repository or in a separate minimal subproject?
8. What is the cleanest way to expose `check_lean`, `run_python`, and `read_goal` as tools?
9. How should we surface tool calls and verifier output so participants can see that Gemini does not certify itself?
10. What failure modes should we expect from ADK during a live workshop?
11. Should we use the Gemini API directly or Vertex AI for an event like this?
12. Which authentication route creates the least participant friction?
13. Can one preconfigured local setup hide most of the ADK/Gemini plumbing?
14. Is Agents CLI useful enough here to justify adding another command-line dependency?

### UI and developer experience

15. Is the existing ADK/Google playground sufficient for the final demonstration?
16. Would a tiny custom frontend materially improve the educational value, or would it only add maintenance risk?
17. If we build a visualization, what is the minimum useful view for the agent trace?
18. What would you remove from the current UX to make it more reliable for 20–50 participants?

### Reproducibility

19. Would Nix materially improve participant setup for this stack, or is it more likely to create onboarding friction?
20. Is there a lightweight reproducibility trick from Angular/Nix/frontend projects that would help us detect broken participant environments early?

The single most useful challenge question is:

> **If you had to make the Google part work reliably for 30 developers who had never used ADK before, with at most 10–15 minutes of setup budget, what would you keep, hide, or remove?**

---

## 25. FAQ for organizer and Google-tooling discussions

### Is this primarily a Lean workshop?

No. Lean is the independent verifier, but the broader subject is trustworthy agentic software development. Participants should understand the architecture even if they do not continue using Lean afterwards.

### Why robotics?

Robotics gives concrete examples where software state has physical consequences. Lifecycle resources, behavior refactoring, industrial protocols, and uncertainty-aware planning are understandable software problems with meaningful correctness requirements.

### Why use Google technologies?

They form the agentic layer rather than being added for branding. Antigravity provides the developer environment, Gemini proposes and repairs, and ADK controls tool use. Lean deliberately remains outside that trust boundary.

### Does Gemini execute Lean directly?

No. Gemini proposes a permitted tool call. The application/ADK layer executes the verifier. This distinction is central to the demo.

### Why not simply ask Gemini whether its solution is correct?

Because confidence or explanation is not a certificate. The point of the workshop is that a strong generative model can still benefit from an independent verifier.

### What happens when Gemini generates an invalid proof?

That is an expected and useful event. ADK sends the candidate to Lean, Lean rejects it, the compiler feedback is returned to Gemini, and Gemini can attempt a repair.

### What tools should the ADK agent receive?

A small allowlist such as `read_file`, `read_goal`, `check_lean`, and `run_python_example`. It should not need arbitrary shell access.

### Do participants need to learn ADK?

Not in depth. They should understand what it does and observe the tool loop. The implementation should be available for inspection, but ADK internals should not consume a large part of the 90 minutes.

### Do we need a custom frontend?

Probably not unless it adds a specific educational benefit. Existing Antigravity/ADK interfaces should be evaluated first. A custom UI is justified only if it clearly visualizes the verification trace better.

### What would a useful trace visualization show?

Something as simple as:

```text
1. Gemini proposed candidate
2. ADK called check_lean
3. Lean returned error
4. Gemini proposed repair
5. ADK called check_lean
6. Lean returned verified
```

### Why is Python included if Lean is the verifier?

Python answers “what happens for this concrete execution?” Lean answers “does the property hold for all states/traces represented by the model?” The combination makes formal verification easier to teach.

### Why is lifecycle/resource handling the first exercise?

Because it is familiar, realistic, and deceptively simple. A node can enter `Inactive` while still holding resources or actuator authority. That makes a strong first invariant example.

### Why is Behavior Tree refinement the main exercise?

Because it introduces a deeper engineering question without requiring advanced mathematics: what does it mean for a rewrite to preserve behavior?

### Is the VDA example a standards certification tool?

No. It is explicitly a VDA 5050-inspired teaching profile. Its purpose is to show that individually valid messages can form an invalid temporal trace.

### Why include uncertainty?

To show that formalization is not limited to state machines. A tiny set-valued perception/planner contract introduces the logical structure behind robust planning and uncertainty sets.

### Will participants need Gemini API keys?

This remains an organizer decision. Event-provided access is preferred. If participant authentication is too costly, the core workshop remains local and the Gemini/ADK loop can be facilitator-led.

### What happens if Wi-Fi fails?

The lifecycle and BT exercises still run locally. Mathlib, Lean Copilot models, Python dependencies, and optional model artifacts should be cached before the event. The cloud-dependent final demo needs a fallback trace or facilitator-prepared path.

### Are local models part of the core workshop?

No. A small Lean model is an optional bonus demonstration showing that different candidate generators can use the same verifier.

### Is LeanDojo required?

No. LeanDojo-v2 is an advanced extension for programmatic proof interaction and prover research. It should not increase participant setup time for the first workshop.

### Is cloud deployment part of the workshop?

Not unless the organizers explicitly require it. Local orchestration is enough to teach the agent architecture and is more reliable in 90 minutes.

### Is Nix required?

No. It is worth discussing as a reproducibility option, especially with Adrian, but it should only be introduced if it reduces net setup friction across the target operating systems.

### Who is responsible for implementing the workshop?

The presenter. Adrian and the organizers provide targeted feedback/support, especially around Google tooling, event logistics, credentials, and participant experience.

### What is the minimum viable Google integration?

```text
Antigravity
    ↓
Gemini
    ↓
ADK tool call
    ↓
check_lean(candidate)
    ↓
Lean result
    ↓
Gemini explanation / repair
```

This is already genuinely Google-centric and demonstrates the central trust boundary.

### What is the success criterion for the final demo?

Participants should clearly see that:

1. Gemini generated a candidate;
2. Gemini did not certify it;
3. ADK invoked an external verifier;
4. Lean accepted or rejected the candidate;
5. verifier feedback could guide the next AI attempt.

### What should implementation decisions optimize for?

In order:

1. reliability during the live event;
2. conceptual clarity;
3. participant setup time;
4. useful hands-on interaction;
5. technical depth;
6. optional sophistication.

### What should we explicitly avoid?

- complex participant cloud-project setup during the session;
- mandatory LeanDojo installation;
- unrestricted shell access for the agent;
- an opaque “AI succeeded” message without verifier output;
- a custom frontend built only for visual polish;
- cloud infrastructure added only to increase the number of Google products;
- another full exercise;
- dependence on perfect conference Wi-Fi;
- presenting the educational VDA monitor as full certification.

The implementation guideline is:

> **Make it easy for the AI to propose, easy for the participant to understand what happened, and impossible for the AI to declare itself verified.**

---

## 26. What should remain outside the first 90 minutes

Interesting but out-of-scope topics include:

- semantic-map verification;
- full VDA 5050 formalization;
- full ROS 2 runtime models;
- advanced MPC/Control Barrier Function proofs;
- continuous-time dynamics;
- full conformal-prediction pipelines;
- LeanDojo training workflows;
- project-specific theorem-prover training;
- mandatory local model serving;
- cloud deployment exercises.

These are potential follow-up workshop or research directions.

---

## 27. Connection to cyber-physical systems

Robotic software sits at the boundary between digital state, communication, timing, physical resources, physical motion, and human interaction.

The strongest early formalization targets are often the interfaces:

```text
May the controller issue this command?
Is this sensor observation fresh enough?
Has the resource been acquired?
Is the lifecycle transition legal?
Is the actuator allowed to remain active?
Does the new implementation preserve the old behavior?
Is this message trace legal?
Does the planner account for the full uncertainty set?
```

These contracts are small enough to formalize but important enough to matter.

The same methodology can later apply to medical robots, rehabilitation systems, industrial cobots, laboratory automation, autonomous logistics, and other safety-critical cyber-physical systems.

---

## 28. Core architecture

```text
                    +----------------------+
                    | Google Antigravity   |
                    | developer interface  |
                    +----------+-----------+
                               |
                               v
                    +----------------------+
                    | Gemini               |
                    | reason / propose     |
                    +----------+-----------+
                               |
                               v
                    +----------------------+
                    | Google ADK           |
                    | constrained tools    |
                    +----+-------------+---+
                         |             |
                         v             v
                 +-----------+   +-----------+
                 | Python    |   | Lean 4    |
                 | execution |   | verifier  |
                 +-----------+   +-----+-----+
                                      |
                                      v
                              +---------------+
                              | Lean kernel   |
                              | final trust   |
                              +---------------+
```

Optional alternative candidate generators—Lean Copilot, Kimina, Aristotle, and future models—connect before the same Lean verification boundary.

---

## 29. Why this fits a Google developer event

The workshop showcases Google technology in a way that is more meaningful than simply calling a Gemini endpoint.

It demonstrates:

- **Antigravity:** an agentic developer environment operating on a real checked codebase;
- **Gemini:** reasoning over requirements, invariants, counterexamples, and proof failures;
- **ADK:** controlled orchestration and tool use;
- **Gemini function calling:** structured model-selected tool invocation while execution remains application-controlled;
- **responsible agent architecture:** the AI is powerful but does not receive unlimited trust.

A useful overall message is:

> **The future of reliable AI development is not necessarily a perfect model. It may be a strong model surrounded by strong verification tools.**

---

## 30. Workshop “aha” moments

1. **A mundane lifecycle bug becomes a theorem.** A forgotten resource release invalidates an invariant.
2. **The rewrite is not equivalent.** The Behavior Tree and handwritten FSM disagree on a small but important case.
3. **Valid messages can form an invalid protocol.** Structural validity is not temporal conformance.
4. **The point estimate was misleading.** An apparently safe obstacle estimate becomes unsafe once uncertainty is represented.
5. **Gemini gives a wrong proof.** That is not a failure of the workshop; it is the point.
6. **Two AI models disagree.** The verifier remains unchanged.

---

## 31. Suggested opening narrative

> We increasingly let AI agents write and modify software. That is useful, but robotics gives us an uncomfortable question: what happens when plausible-looking generated code controls a physical machine?
>
> I ran into a version of this problem before the current AI-agent wave. In a fleet-management system, maintaining robot state machines and Behavior Trees became difficult enough that a large Behavior Tree implementation was eventually replaced by handwritten state-transition logic. The rewrite may have looked reasonable, but we had no machine-checked statement saying what behavior had to remain unchanged.
>
> Today an AI agent could perform the same rewrite in minutes. That makes the old question even more important.
>
> In this workshop, the AI is allowed to make proposals. It is not allowed to certify itself.

---

## 32. Suggested closing narrative

> We started with a lifecycle node forgetting to release a resource. We then checked whether a Behavior Tree refactor preserved behavior, looked at temporal conformance of industrial-style messages, and finished with a planner reasoning over an uncertainty set.
>
> The common pattern was not a specific theorem prover or a specific AI model. It was the separation between proposing and verifying.
>
> Gemini can reason, explain, generate, and repair. ADK can orchestrate tools. Antigravity can make that workflow comfortable for a developer. Lean gives us an independent trust boundary.
>
> AI can propose. The verifier decides.

---

## 33. Organizer decisions needed before finalizing the workshop

The main decisions are:

1. confirm the Google technologies that should appear in the official workshop description;
2. confirm whether Gemini access/credits can be provided;
3. decide whether Antigravity is a participant requirement or facilitator-first environment;
4. decide whether ADK is hands-on for everyone or primarily demonstrated;
5. confirm participant laptop expectations;
6. confirm supported operating systems;
7. confirm whether pre-event setup instructions can be sent;
8. confirm expected participant count;
9. confirm network constraints;
10. agree on the final public title and abstract.

---

## 34. Recommended scope for version 1

### Must have

- English repository and presentation;
- Antigravity incorporated into the Google workflow;
- Gemini as the reasoning/repair model;
- ADK as constrained tool orchestrator;
- Lean 4 as verifier;
- Lean Copilot as native theorem-proving assistant;
- lifecycle exercise;
- BT refinement exercise;
- VDA short demo;
- uncertainty short demo;
- final Gemini + ADK proof-repair demo;
- local/offline fallback;
- no GitHub Actions.

### Nice to have

- local Kimina model;
- one multiple-model comparison;
- optional LeanDojo-v2 integration;
- optional facilitator Aristotle integration;
- Agents CLI development support.

### Not for the first 90 minutes

- full semantic maps;
- full VDA 5050 certification;
- full ROS 2 runtime;
- full LeanDojo training workflow;
- advanced MPC/CBF proofs;
- full conformal-prediction pipeline;
- cloud deployment exercise.

---

## 35. Immediate next technical work

Before presenting the workshop plan as final, the repository should go through the following sequence:

1. resolve correctness/security findings from PR review;
2. run the complete native Lean build on the reference machine;
3. validate Lean Copilot with the pinned Lean/Mathlib version;
4. generate and review reproducibility lockfiles;
5. test the complete setup from a clean clone;
6. implement the Gemini backend;
7. connect the Gemini backend to the constrained ADK Lean tools;
8. test an intentional “wrong proof → compiler feedback → repaired proof” demo;
9. test Antigravity with the exact participant repository;
10. decide whether to add the optional Kimina path before the event;
11. prepare an offline workshop bundle;
12. perform a full 90-minute rehearsal;
13. shorten any segment that regularly exceeds its timebox.

---

## 36. Proposed framing for organizers

> This is not intended to be a Lean workshop with Gemini added for branding. The Google technologies are the agentic layer of the system.
>
> Antigravity is where the developer works. Gemini interprets the task and proposes changes. ADK controls the tools that the agent is permitted to use. Lean provides an independent verifier for the resulting code.
>
> The central demonstration is therefore a trustworthy agent loop rather than a chatbot demo.

---

## 37. Final one-paragraph concept

**From Hallucination to Proof** is a 90-minute hands-on workshop about building AI agents that are useful without requiring blind trust. Participants use Google Antigravity, Gemini, and Google Agent Development Kit to analyze and modify small robotics programs, while Python provides executable counterexamples and Lean 4 provides formal verification. The core exercises cover ROS 2-style lifecycle/resource invariants and Behavior Tree-to-FSM refinement, followed by short demonstrations of VDA 5050-style temporal conformance and perception-planning under uncertainty. The final demo closes the loop: Gemini proposes a proof, ADK invokes a constrained Lean checker, Lean rejects an incorrect candidate, and Gemini repairs it using compiler feedback. The message is simple: **AI can propose; the verifier decides.**
