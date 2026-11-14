# From Hallucination to Proof

**Trustworthy AI-assisted robotics development with Gemini and Lean 4**

This repository contains a **45-minute, self-running workshop** on trustworthy
AI-assisted development for robotics software. The participant may work
manually, use Codex/Claude Code/Gemini, or connect a small local model. The
verification boundary is the same in every case:

```text
AI proposal -> executable check -> Lean -> verified or rejected
```

## Fastest start

The expensive setup is intended to happen **before** the workshop:

```bash
./workshop prepare
```

At the event:

```bash
git switch workshop/00-build
./workshop task start
```

Then follow the command printed by the task runner. Each checkpoint branch
contains one short `WORKSHOP_TASK.md`.

The complete 45-minute route is documented in
[`course/45min/README.md`](course/45min/README.md).

## Agent users

### Codex and AGENTS.md-aware tools

Open the repository on the current task branch and ask:

```text
Follow AGENTS.md and complete the current workshop task.
```

### Claude Code

`CLAUDE.md` redirects Claude Code to the same canonical `AGENTS.md` contract,
so the task semantics stay identical.

### Gemini / Antigravity

`GEMINI.md` uses the same trust boundary. The Google ADK integration remains
optional; the core course does not depend on cloud access.

### Local laptop model

A lightweight `llama.cpp` recipe is provided:

```bash
./workshop local-agent profiles
./workshop local-agent serve tiny
# or, on a stronger laptop:
./workshop local-agent serve standard
```

See [`docs/local-agent-recipe.md`](docs/local-agent-recipe.md).

## 45-minute route

| Time | Checkpoint | Goal |
|---:|---|---|
| 0–4 min | `00-build` | environment + trust boundary |
| 4–12 min | `01-lifecycle` | resource invariant |
| 12–23 min | `02-bt-refinement` | BT → FSM behavioral refinement |
| 23–29 min | `03-vda-trace` | temporal trace conformance |
| 29–35 min | `04-uncertainty` | set-valued planner contract |
| 35–42 min | `05-agent-loop` | bad candidate → Lean rejection → repair |
| 42–45 min | wrap-up | what was and was not verified |

Every task has a matching `-solution` branch. The next task branch is based on
the previous solution branch, so falling behind does not block the rest of the
course.

## Core commands

```bash
./workshop quickcheck
./workshop task status
./workshop task start
./workshop task check
./workshop task next
./workshop task solution
```

`task solution` only prints the solution branch by default. Passing
`--checkout` explicitly backs up the active playground and switches to it.

## Formal-verification claim boundary

A successful Lean proof establishes a theorem **about the formal model and
assumptions in this repository**. It does not automatically prove that the
physical robot, ROS 2 runtime, network, perception system, or environment has
been modeled completely.

The workshop therefore keeps three questions separate:

1. Is the formal claim true of the model?
2. Does the model capture the relevant part of the real system?
3. Did we formalize the right requirement?

Lean is the authority for the first question. The second and third remain
specification and engineering work.

## Extended material

The older detailed curriculum under `curriculum/` remains useful for a longer
session and post-workshop study. The branch-based route under `course/45min/`
is the authority for the 45-minute event.

GitHub Actions remain disabled. Repository acceptance is local.
