# Workshop Discussion Brief

## From Hallucination to Proof: Trustworthy AI Agents with Gemini and Lean 4

**Working document for discussion with event organizers**

- **Format:** 90-minute hands-on workshop
- **Presentation language:** English
- **Repository language:** English
- **Repository:** `verified-agentic-lean4-workshop`
- **Core principle:** **AI can propose; the verifier decides.**
- **Current status:** private workshop repository and draft implementation under active development

---

## 1. Purpose of this document

This document consolidates the workshop concept developed so far and is intended to be the starting point for discussion with the organizers.

Because the event is Google-centered, the Google technology stack should not appear as a cosmetic addition. The goal is to make **Google Antigravity, Gemini, and Google Agent Development Kit (ADK)** integral parts of the workflow while keeping the central technical message scientifically honest:

> Generative AI can be extremely useful even when we do not blindly trust its output.

The workshop combines agentic software development with formal verification. Gemini can analyze requirements, suggest invariants, generate proof candidates, interpret compiler feedback, and repair failed attempts. ADK provides a controlled tool-use loop. Antigravity provides the developer-facing environment. Lean 4 remains the independent authority that decides whether the formal claim actually holds.

This creates a natural trust boundary:

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

## 2. Why this workshop

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

## 4. Working title and abstract

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

The model also contains cleanup, shutdown, and recovery paths.

### Example invariant

```text
Active
    → sensorOpen ∧ logOpen

actuatorEnabled
    → Active

Unconfigured ∨ Finalized
    → ¬sensorOpen
      ∧ ¬logOpen
      ∧ ¬actuatorEnabled
```

### Deliberate bug

The buggy implementation performs:

```text
Active → Inactive
```

but forgets to disable the actuator, release the sensor, and close the log.

The lifecycle transition itself appears superficially correct. The application invariant is not.

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

### Motivation

This exercise directly reflects the real fleet-management refactoring story.

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

### Deliberate refactoring bug

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

This is an ideal formal-methods example because the bug is simple enough to understand immediately but realistic enough to matter.

### What Lean proves

The reference development proves:

1. a concrete counterexample to the buggy implementation;
2. pointwise equivalence of the repaired FSM and the reference BT;
3. equality of their observable decisions over every finite observation trace.

The conceptual progression is:

```text
example test
    ↓
counterexample
    ↓
universal statement for one observation
    ↓
trace-level equivalence
```

### Scope limitation

The first workshop model intentionally omits:

- `RUNNING`;
- asynchronous Behavior Tree actions;
- blackboard state;
- action cancellation internals;
- concurrent subtrees.

These features are important, but they would turn the session into a BehaviorTree.CPP semantics project rather than a first introduction to refinement.

---

## 9. Demo 1: VDA 5050-style temporal conformance

Industrial standards are a strong example of a less obvious use of formalization.

A JSON Schema can tell us whether an individual message has the correct structure. It cannot by itself prove that an entire temporal sequence of messages represents legal behavior.

```text
structural validity
    ≠
behavioral conformance
```

The current educational profile tracks order ID, order update ID, and last reported node sequence ID.

It can reject traces such as:

```text
order(7, update=0)
order(7, update=0)
```

or:

```text
state(nodeSequence=4)
state(nodeSequence=3)
```

The extended demonstration returns typed reasons such as:

```text
orderUpdateNotIncreasing
nodeSequenceRegressed
```

and the Python side can report the index of the first rejected message.

### Claim discipline

This must be described as **a VDA 5050-inspired teaching profile**, not a complete VDA 5050 certification tool.

A real verifier would require systematic formalization of the relevant version of the standard.

A future industrial direction is nevertheless clear:

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

## 10. Demo 2: perception → planner contract under uncertainty

This demonstration shows that formal verification is not limited to state machines.

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

But if the perception component actually certifies:

```text
obstacle ∈ [6, 10]
```

then:

```text
[6, 10] ∩ [0, 8] ≠ ∅
→ FALLBACK
```

Lean proves a contract of the form:

```text
if the planner accepts,
then for every path point
and every obstacle position allowed by the uncertainty set,
the two positions are different.
```

The one-dimensional interval is intentionally small, but the logical structure scales to bounding boxes, polytopes, reachable sets, robust planning, conformal prediction sets, and uncertainty-aware collision checking.

---

## 11. Main Google technology story

The Google technologies should be part of the actual reasoning loop.

### Google Antigravity IDE

Antigravity IDE should be the main developer-facing environment for the agentic portion.

Participants can use it to inspect the repository, edit Python and Lean files, interact with an AI coding agent, ask the agent to explain failed proofs, request invariants, generate candidate repairs, and inspect resulting changes.

The useful framing is not:

> “We use Antigravity because this is a Google event.”

It is:

> “Antigravity is the environment in which an AI agent interacts with a formally checked codebase.”

### Gemini

Gemini should act as the reasoning and repair layer.

Useful tasks include:

- translate an informal requirement into a candidate invariant;
- explain why a theorem failed;
- suggest missing cases;
- generate a proof candidate;
- compare two implementations;
- interpret a counterexample;
- propose a safer implementation;
- decide which verification tool to invoke next.

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

A representative loop is:

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

### Gemini API function calling

The architecture naturally maps to Gemini function calling:

1. the application exposes a constrained tool schema;
2. Gemini selects a tool and supplies arguments;
3. the application executes the tool;
4. the result is returned to Gemini;
5. Gemini decides the next step.

The important security property is that the model proposes the function call, while the application controls what actually executes.

### Agents CLI

Google's Agents CLI is potentially useful on the facilitator/development side for scaffolding an ADK prototype, running a local playground, testing agent traces, and later adding evaluation or deployment support.

It is probably not necessary to teach Agents CLI itself during the 90-minute workshop.

---

## 12. Proposed final Google demo

The final 10–12 minutes should contain the most explicit Google demonstration.

### Demo: the agent is allowed to fail

1. Open an incomplete Lean proof in Antigravity.
2. Ask Gemini to propose and verify a proof.
3. Gemini produces a plausible but invalid candidate.
4. The ADK agent invokes the constrained Lean checker.
5. Lean rejects the candidate.
6. The compiler feedback is returned to Gemini.
7. Gemini repairs the proof.
8. ADK invokes Lean again.
9. Lean accepts the corrected proof.

The lesson is:

> **The model was useful without being trusted.**

A strong workshop sentence is:

> **The agent is allowed to be wrong. The verification boundary is not.**

---

## 13. Optional bonus demo: multiple AI systems, one verifier

If time allows, the same theorem can be given to:

```text
Lean Copilot
local Kimina
Gemini
```

Example result:

```text
                 candidate        Lean result
Lean Copilot         A                ✓
Kimina               B                ✗
Gemini               C                ✓
```

The objective is not to rank the models.

The message is:

> Different models may disagree. Lean does not vote.

This demonstrates why generation, orchestration, and verification should remain separate layers.

---

## 14. Lean Copilot

Lean Copilot should remain the native Lean helper.

Useful commands include:

```lean
suggest_tactics
search_proof
select_premises
```

The intended division of labor is:

```text
Lean Copilot
    → small interactive tactic suggestions

Gemini
    → reasoning, explanation, repair, orchestration

local theorem model
    → optional alternative proof candidates

Lean
    → final authority
```

An important limitation is that Lean Copilot's built-in premise retriever uses a fixed snapshot of Lean/mathlib. A project-aware premise index for the exact workshop repository is a possible future research extension, not a first-workshop requirement.

---

## 15. LeanDojo-v2

LeanDojo should be treated as an optional research extension rather than a participant requirement.

Possible future uses include:

- programmatic Lean interaction;
- proof-state extraction;
- training datasets;
- prover evaluation;
- custom premise retrieval;
- automated proof search;
- integration with local models.

The original LeanDojo library is deprecated for new projects; future work should target LeanDojo-v2.

For the first workshop, the recommended split is:

```text
Core workshop:
Lean 4
Mathlib
Lean Copilot
Python
Antigravity
Gemini/ADK when credentials are available

Optional advanced track:
LeanDojo-v2
local theorem model
custom premise index
```

This keeps the participant setup small.

---

## 16. Small local theorem-proving models

Local models are useful because the workshop can demonstrate a cloud-independent proof generator and because the same Lean verifier can check candidates from different model families.

The small models discussed so far are:

- **Kimina-Prover-RL-0.6B**;
- **Kimina-Prover-RL-1.7B**.

These are specialized Lean 4 theorem-proving models rather than general chat models.

The smaller model is appropriate for ordinary participant laptops. The 1.7B model is more appropriate for stronger laptops or the facilitator machine.

A future participant-facing interface could look like:

```bash
./workshop model download kimina-0.6b
./workshop model serve kimina-0.6b
./workshop model status
```

and later:

```bash
./workshop dojo propose \
  playground/current/Current.lean \
  theorem_name \
  --model local
```

This should remain optional for the first workshop.

---

## 17. Aristotle / Harmonic

The repository is also designed to remain compatible with Aristotle-style Lean projects.

Aristotle is useful primarily for facilitator preparation, research workflows, larger proof generation/repair, and comparison with other theorem-proving systems.

It is not necessary for every participant.

The broader architecture is intentionally model-agnostic:

```text
Gemini
Lean Copilot
Kimina
Aristotle
other future models
        |
        v
candidate Lean
        |
        v
same verification boundary
```

---

## 18. Repository design and current workflow

The repository is:

```text
verified-agentic-lean4-workshop
```

All repository material is written in English.

The project preserves a conventional Lean/Lake structure so that it remains easy to use with Lean, Mathlib, Lean Copilot, Aristotle, and future LeanDojo integration.

The participant command surface is intentionally small.

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

The current scenario is placed under:

```text
playground/current/
```

Before replacing current work, the loader creates a backup under:

```text
playground/backups/
```

The first workshop contains four scenario families:

```text
lifecycle
bt
vda
uncertainty
```

For each scenario the repository contains an unsolved Lean exercise, unsolved Python exercise, shared Lean model, reference Lean proof, and reference Python implementation.

A useful teaching slogan is:

```text
Python:
“Show me what happens.”

Lean:
“Show me that it always happens.”
```

---

## 19. Trust boundary in the repository

The repository intentionally rejects common proof bypasses such as:

```text
sorry
admit
new axioms
native_decide
implemented_by
```

The active Lean file is then compiled.

The Google ADK agent should follow the same rule:

```text
agent-generated text != verified proof
```

The agent may only report success after the actual Lean checker succeeds.

This principle should appear explicitly in the README, agent instructions, live workshop, and organizer description.

---

## 20. No GitHub Actions

GitHub Actions are intentionally not part of this project.

Validation is local.

This avoids hosted CI cost and is educationally useful because participants can see the complete verification process on their own machines.

The local acceptance command is:

```bash
./workshop check
```

Development and release preparation rely on local shell checks, Python tests, Lean compilation, and explicit reference-solution validation.

---

## 21. Current development status

The current private repository already contains a substantial first implementation.

The active draft pull request includes:

- the four scenarios;
- Python and Lean versions;
- reference solutions;
- participant and facilitator guides;
- a live-demo script;
- an optional constrained Google ADK agent;
- local trust-boundary checks;
- automatic participant backups;
- local regression tests.

Current local non-Lean validation includes passing scenario and workflow regression tests.

The major remaining native acceptance step is:

```text
full Lean build
+
Lean Copilot model download
+
lockfile generation
+
clean-clone validation
```

on the reference machine.

The repository should remain private until the workshop structure and organizer requirements are settled.

---

## 22. Participant setup philosophy

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

Preferred environments are Linux, macOS, and Windows through WSL 2, with an editor that supports Lean 4 and Google Antigravity IDE for the agentic portion.

Core dependencies are Git, Git LFS, Lean via `elan`, Python 3.11/3.12, and `uv`.

Optional components include Kimina, LeanDojo-v2, Gemini API credentials, and Aristotle credentials.

---

## 23. Internet and offline fallback

The workshop should not depend on perfect conference Wi-Fi.

Before the event, prepare offline copies of:

- the repository;
- Mathlib cache;
- Lean Copilot model cache;
- Python wheels;
- optional Kimina model.

The core lifecycle and BT exercises should work even when Gemini is unavailable.

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

This is important for a live event.

---

## 24. Gemini API credentials and event support

This is one of the main topics to discuss with the organizers.

The workshop should avoid requiring every participant to enter a credit card, manually create a cloud project during the session, copy long-lived secrets into source files, or expose API keys to other participants.

Preferred possibilities:

### Option A — event-provided credits / credentials

The organizers provide an approved way for participants to access Gemini during the event.

### Option B — participants use their own Google accounts

This may work if the audience is already expected to have access to the required developer tooling. The onboarding flow should be tested in advance.

### Option C — facilitator-only cloud demo

If participant credentials are too difficult, the main exercises remain local and the Gemini + ADK loop is demonstrated by the facilitator.

No secret should ever be committed to the repository. Local configuration should use environment variables or an ignored `.env` file.

---

## 25. Questions for organizers

### Technology and program requirements

1. Is **Antigravity + Gemini + ADK** sufficient to satisfy the Google-technology requirement?
2. Is there a preference for Gemini API versus Vertex AI access?
3. Are organizers interested in showcasing Agents CLI as well?
4. Should a Google Cloud deployment component be included, or is local agent orchestration preferable for 90 minutes?

### Credentials and credits

5. Can the event provide Gemini API credits or another approved access path?
6. Can participants receive temporary or event-scoped credentials?
7. Is there an existing DevFest/Google developer-credit process we should use?
8. What is the expected policy for participant API keys?

### Participant machines

9. Will participants be expected to bring laptops?
10. Which operating systems should we officially support?
11. Can we send a pre-event setup checklist?
12. Can we ask participants to run a setup test before arrival?

### Network

13. How reliable is conference Wi-Fi expected to be?
14. Can the facilitator machine host a small local service if needed?
15. Are there firewall restrictions on local HTTP endpoints?

### Workshop format

16. What technical level is expected?
17. Is the 90-minute duration fixed?
18. What is the expected number of participants?
19. Can we recommend working in pairs?
20. Can the workshop listing state that setup should be completed before arrival?

---

## 26. What should remain outside the first 90 minutes

Several ideas are interesting but would overload the first workshop.

### Semantic maps

Formal verification of semantic maps is promising for well-formed topology, routing-graph refinement, affordance constraints, map-version migration, and planner-map consistency. However, it requires too much domain modeling for the first session.

### Full MPC / control-theoretic verification

Lyapunov proofs, MPC feasibility, Control Barrier Functions, and continuous dynamics would be technically strong but would move attention away from the agentic-verification workflow.

### Full VDA 5050 formalization

The current VDA demonstration should remain intentionally small. A full version belongs in a separate project.

### Full LeanDojo participant setup

LeanDojo-v2 is valuable, but installation and model tooling can consume too much workshop time.

### Full conformal-prediction pipeline

The uncertainty demo can mention conformal prediction, but the first workshop should not require participants to learn it.

---

## 27. Possible future advanced workshop

A follow-up workshop could be titled:

# Verified AI for Cyber-Physical Systems

Possible topics:

- formal ROS 2 lifecycle contracts;
- Behavior Tree refinement;
- distributed robot-state consistency;
- VDA 5050 versioned conformance;
- semantic-map invariants;
- conformal prediction contracts;
- planner/controller contracts;
- MPC/CBF fallback supervisors;
- LeanDojo-v2;
- project-specific premise retrieval;
- local theorem-proving models;
- agent evaluation.

This would connect the lightweight first workshop to serious research in trustworthy robotics.

---

## 28. Connection to cyber-physical systems

Robotic software sits at the boundary between digital state, communication, timing, physical resources, physical motion, and human interaction.

The strongest early formalization targets are often the interfaces rather than the continuous dynamics themselves:

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

The same methodology can later apply to medical robots, infusion pumps, rehabilitation robots, industrial cobots, laboratory automation, and autonomous logistics, without adding separate medical exercises to the first workshop.

---

## 29. Core architecture

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

## 30. Why this fits a Google developer event

The workshop can showcase Google technology in a way that is more meaningful than simply calling a Gemini endpoint.

It demonstrates:

- **Antigravity:** an agentic developer environment working on a real codebase;
- **Gemini:** reasoning over requirements, invariants, counterexamples, and proof failures;
- **ADK:** controlled orchestration and tool use;
- **Gemini function calling:** the model selects tools while the application retains execution authority;
- **responsible agent architecture:** the AI is powerful but does not get unlimited trust or arbitrary shell access.

A useful overall message is:

> **The future of reliable AI development is not necessarily a perfect model. It may be a strong model surrounded by strong verification tools.**

---

## 31. Workshop “aha” moments

1. **A boring lifecycle bug becomes a theorem.** A forgotten resource release invalidates an invariant.
2. **The rewrite is not equivalent.** The Behavior Tree and handwritten FSM disagree on a small but important case.
3. **Valid messages can form an invalid protocol.** JSON validity is not temporal conformance.
4. **The point estimate was misleading.** A safe-looking obstacle estimate becomes unsafe once uncertainty is represented.
5. **Gemini gives a wrong proof.** That is not a failure of the workshop; it is the point. ADK sends the candidate to Lean, Lean rejects it, and Gemini gets feedback.
6. **Two AI models disagree.** The verifier remains unchanged.

---

## 32. Suggested opening narrative

> We increasingly let AI agents write and modify software. That is useful, but robotics gives us an uncomfortable question: what happens when plausible-looking generated code controls a physical machine?
>
> I ran into a version of this problem before the current AI-agent wave. In a fleet-management system, maintaining robot state machines and Behavior Trees became difficult enough that a large Behavior Tree implementation was eventually replaced by handwritten state-transition logic. The rewrite may have looked reasonable, but we had no machine-checked statement saying what behavior had to remain unchanged.
>
> Today an AI agent could perform the same rewrite in minutes. That makes the old question even more important.
>
> In this workshop, the AI is allowed to make proposals. It is not allowed to certify itself.

---

## 33. Suggested closing narrative

> We started with a lifecycle node forgetting to release a resource. We then checked whether a Behavior Tree refactor preserved behavior, looked at temporal conformance of industrial-style messages, and finished with a planner reasoning over an uncertainty set.
>
> The common pattern was not a specific theorem prover or a specific AI model. It was the separation between proposing and verifying.
>
> Gemini can reason, explain, generate, and repair. ADK can orchestrate tools. Antigravity can make that workflow comfortable for a developer. Lean gives us an independent trust boundary.
>
> AI can propose. The verifier decides.

---

## 34. Organizer decisions needed before finalizing the workshop

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

## 35. Recommended scope for version 1

### Must have

- English repository and presentation;
- Antigravity in the workflow;
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

## 36. Immediate next technical work

Before presenting the workshop plan as final, the repository should go through the following sequence:

1. run the complete native Lean build on the reference machine;
2. validate Lean Copilot with the pinned Lean/Mathlib version;
3. generate and review reproducibility lockfiles;
4. test the complete setup from a clean clone;
5. implement the Gemini backend;
6. connect the Gemini backend to the constrained ADK Lean tools;
7. test an intentional “wrong proof → compiler feedback → repaired proof” demo;
8. test Antigravity with the exact participant repository;
9. decide whether to add the optional Kimina path before the event;
10. prepare an offline workshop bundle;
11. perform a full 90-minute rehearsal;
12. shorten any segment that regularly exceeds its timebox.

---

## 37. Proposed framing for the organizers

A useful way to frame the workshop is:

> This is not intended to be a Lean workshop with Gemini added for branding. The Google technologies are the agentic layer of the system.
>
> Antigravity is where the developer works. Gemini interprets the task and proposes changes. ADK controls the tools that the agent is permitted to use. Lean provides an independent verifier for the resulting code.
>
> The central demonstration is therefore a trustworthy agent loop rather than a chatbot demo.

This distinction should make the workshop a stronger fit for a Google developer event.

---

## 38. Final one-paragraph concept

**From Hallucination to Proof** is a 90-minute hands-on workshop about building AI agents that are useful without requiring blind trust. Participants use Google Antigravity, Gemini, and Google Agent Development Kit to analyze and modify small robotics programs, while Python provides executable counterexamples and Lean 4 provides formal verification. The core exercises cover ROS 2-style lifecycle/resource invariants and Behavior Tree-to-FSM refinement, followed by short demonstrations of VDA 5050-style temporal conformance and perception-planning under uncertainty. The final demo closes the loop: Gemini proposes a proof, ADK invokes a constrained Lean checker, Lean rejects an incorrect candidate, and Gemini repairs it using compiler feedback. The message is simple: **AI can propose; the verifier decides.**
