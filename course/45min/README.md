# 45-Minute Self-Running Course

This is the event path. It is deliberately shorter than the extended
`curriculum/` material.

The course uses Git branches as verified checkpoints. Every task branch has a
matching solution branch, and every next task starts from the previous solution.

That gives us a useful property:

```text
participant falls behind
        ↓
their current work is backed up
        ↓
switch to next task branch
        ↓
previous task is already in its verified solution state
        ↓
continue with the room
```

## Before the event

Run once:

```bash
./workshop prepare
```

Optional local model:

```bash
./workshop prepare --local-agent tiny
# or
./workshop prepare --local-agent standard
```

This is when dependency and model downloads should happen.

## During the 45 minutes

Start:

```bash
git switch workshop/00-build
./workshop task start
```

Then use only:

```bash
./workshop task check
./workshop task next
```

If you need help from a coding agent:

```bash
./workshop task prompt
```

Paste the returned sentence into Codex, Claude Code, Gemini/Antigravity, or an
agent connected to the local llama.cpp endpoint.

## Schedule

| Minutes | Branch | What participants learn |
|---:|---|---|
| 0–4 | `workshop/00-build` | trust boundary and fast preflight |
| 4–12 | `workshop/01-lifecycle` | invariant vs concrete execution |
| 12–23 | `workshop/02-bt-refinement` | counterexample and behavioral refinement |
| 23–29 | `workshop/03-vda-trace` | structural validity vs temporal conformance |
| 29–35 | `workshop/04-uncertainty` | point estimate vs set-valued contract |
| 35–42 | `workshop/05-agent-loop` | guaranteed rejection/repair loop |
| 42–45 | wrap-up | proof scope, assumptions, specification risk |

## Solution branches

Every task has a `-solution` branch. By default:

```bash
./workshop task solution
```

only prints its name. To explicitly inspect it:

```bash
./workshop task solution --checkout
```

The next task branch is already based on that solution, so participants normally
do not need to inspect the answer branch during the live session.

## Agent contract

All agents follow the same files:

```text
AGENTS.md
WORKSHOP_TASK.md
```

Claude Code receives the same contract through `CLAUDE.md`.

The expected autonomous loop is:

```text
read task
→ start scenario
→ inspect definitions
→ make smallest edit
→ run task check
→ use real diagnostic
→ repeat
→ stop at WORKSHOP_TASK_OK
```

## Local-model expectations

The tiny local model is a fallback tutor, not a theorem prover. The standard
4B Q4 profile is more useful for coding suggestions while still fitting
ordinary laptop-class hardware. Neither profile is trusted.

A weak local model is acceptable because each task is deliberately narrow and
the repository supplies the context, files, commands, verifier, and stopping
condition.

See `docs/local-agent-recipe.md`.
