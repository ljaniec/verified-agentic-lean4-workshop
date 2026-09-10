# Facilitator Rehearsal Checklist

Use this checklist before the workshop is published and again on the instructor
machine shortly before the event. The purpose is to validate the exact path a
participant will see, not only the reference solutions.

## 1. Create separate participant and reference worktrees

```bash
git fetch origin

git worktree add ../verified-agentic-lean4-workshop-participant \
  agent/initial-workshop-platform

git worktree add ../verified-agentic-lean4-workshop-solutions \
  workshop/reference-solutions
```

Never switch the projected participant checkout to the reference branch during
the live session.

## 2. Validate the participant checkout

From the participant worktree:

```bash
./workshop doctor
./workshop setup
./workshop check
```

Confirm that:

- no GitHub Actions workflow exists;
- no reference solution directory exists;
- `./workshop scenario solution` is unavailable;
- all four starters can be loaded;
- loading a new starter backs up existing participant work.

## 3. Rehearse the lifecycle exercise as a beginner

```bash
./workshop scenario start lifecycle
./workshop scenario status
```

Follow `curriculum/01-lifecycle-resources/` in order. Do not use the reference
worktree until you have reproduced the participant experience.

Important acceptance point: after Tasks 01.1–01.5 are completed, the ordinary
`./workshop scenario check` must pass. The optional trace theorem in Task 01.6
must not block participants who skip the stretch task.

Record the elapsed time. The required path should fit within the allocated
20-minute stage on a machine with dependencies already prepared.

## 4. Rehearse the Behavior Tree exercise as a beginner

```bash
./workshop scenario start bt
./workshop scenario status
```

Follow `curriculum/02-behavior-tree-refinement/` in order.

Important acceptance point: after Tasks 02.1–02.4 are completed, the ordinary
`./workshop scenario check` must pass. Task 02.5 is optional and must not leave
an unresolved theorem in the baseline starter.

Record the elapsed time and note any instruction that requires knowledge not
introduced earlier in the workshop.

## 5. Validate the reference checkout

From the reference worktree:

```bash
./workshop check
./workshop scenario verify-solutions

for scenario in lifecycle bt vda uncertainty; do
  ./workshop scenario solution "$scenario"
  ./workshop scenario check
done
```

The reference branch must be based on the current participant branch. Before
release, verify:

```bash
git rev-list --left-right --count \
  agent/initial-workshop-platform...workshop/reference-solutions
```

The reference branch may be ahead because it contains the answer overlay, but
it must not be behind the participant branch.

## 6. Rehearse both facilitator demos

Use the reference worktree and follow:

```text
curriculum/03-vda5050-demo/
curriculum/04-uncertainty-demo/
```

Check that every command, expected diagnostic, and claim boundary matches the
actual implementation. Keep each demo under its timebox.

## 7. Freeze the Gemini demonstration only after an end-to-end run

Do not make the cloud path critical until the exact event configuration has
been tested. Freeze and record:

- Gemini model identifier;
- authentication method;
- ADK invocation command;
- exposed tool schemas;
- theorem used in the demo;
- known-invalid candidate;
- expected Lean rejection;
- known-corrected candidate;
- successful Lean result;
- deterministic local fallback.

The visible sequence must remain:

```text
Gemini candidate
→ constrained tool call
→ Lean rejection
→ verifier feedback
→ repaired candidate
→ Lean verification
```

A model response must never be displayed as `verified` before the real checker
returns success.

## 8. Test degraded modes

Rehearse at least these failures:

1. no Gemini/API access;
2. no Lean Copilot model weights;
3. no network after dependencies have been cached;
4. participant starts the next scenario with unfinished work;
5. participant edits the scenario metadata files;
6. an AI proposal contains a forbidden proof bypass.

The core lifecycle and BT exercises must remain teachable without cloud access.

## 9. Final release gate

Immediately before publishing the participant project:

```bash
./workshop check
```

Then perform a fresh clone on a machine or directory that has never used the
repository and repeat the participant setup. Do not use successful results from
a warm development checkout as the final release evidence.
