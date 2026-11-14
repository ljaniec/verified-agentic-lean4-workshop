# Participant Debugging Guide

> Optional local/extended material. For the current 45-minute event, follow
> the [browser task guide](../course/browser/README.md) and
> [supplied agenda](../presentation/workshop-agenda.pdf).

Use this page when the workshop command fails and the error is not immediately
clear. The goal is to identify which layer rejected the current attempt rather
than guessing.

## 1. Identify the failing layer

The workshop deliberately uses several independent checks:

```text
Python execution
    → concrete behavior / counterexample

Lean elaboration and kernel checking
    → formal claim accepted or rejected

static workshop guard
    → rejects explicit proof bypasses
```

A failure in one layer does not imply that the others are broken.

## 2. `./workshop scenario check` fails in Python

Run the Python file directly:

```bash
python3 playground/current/current.py
```

Typical causes during the exercises are:

- a TODO still raises `NotImplementedError`;
- an assertion found a real counterexample;
- the repaired transition/policy does not match the required behavior.

Do not weaken the assertion or safety predicate merely to make the file pass.
Repair the implementation or revisit the requirement.

## 3. Lean shows an unsolved goal

Read the theorem statement first. Then inspect:

- the hypotheses in the local context;
- the exact target;
- the definitions mentioned by the theorem.

For the workshop examples, useful tools include:

```lean
simp?
exact?
apply?
aesop?
suggest_tactics
search_proof
```

Treat every generated suggestion as a candidate. The proof is accepted only
when Lean elaborates and checks the exact declaration.

## 4. A theorem is solved but the file still has errors

This can be normal while you are part-way through an exercise. Later baseline
TODO declarations may still be unfinished.

Use the Lean editor to confirm that the theorem you just edited has no remaining
goal/error at that declaration. Run the full:

```bash
./workshop scenario check
```

only after all required baseline TODOs for the current scenario are complete.
Optional stretch theorems are not predeclared in the baseline starter, so
skipping them will not block the final scenario check.

## 5. The workshop guard rejects the file

The participant checker intentionally rejects explicit trust bypasses such as
`sorry`, `admit`, new axioms/constants used as assumptions, `sorryAx`,
`native_decide`, and `implemented_by` in checked participant proof code.

The guard is not the proof engine; Lean remains the final authority. The guard
exists so the workshop cannot accidentally turn an unfinished or externally
implemented proof into a success message.

## 6. A new scenario replaced unfinished work

The loader backs up the current editable pair before replacing it. Inspect:

```text
playground/backups/
```

Use:

```bash
./workshop scenario status
```

before switching when you are unsure which scenario is active.

## 7. Gemini or another AI gives a confident but invalid answer

Keep the candidate and send it through the same checker. Compiler feedback is
part of the workflow:

```text
candidate
→ verifier rejection
→ diagnostic
→ repair
→ verifier re-check
```

Do not replace this loop with "the model says it is correct".

## 8. You are running out of time

Follow [`curriculum/CATCH_UP.md`](../curriculum/CATCH_UP.md). Preserve the work,
move with the room, and return to the unfinished proof after the demos.
