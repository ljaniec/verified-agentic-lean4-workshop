# Catch-Up Protocol

Falling behind should not prevent you from seeing the rest of the workshop.
The exercises are deliberately staged so that unfinished work can be preserved
and revisited later.

## When the facilitator moves on

Do not rush a proof by copying an answer you do not understand. Instead:

1. save the current files;
2. note which task you reached;
3. start the next scenario when instructed;
4. let the workshop tool create a backup automatically.

For example:

```bash
./workshop scenario status
./workshop scenario start bt
```

Your previous editable pair is copied under:

```text
playground/backups/
```

before the next starter is loaded.

## What counts as the minimum path

For the lifecycle stage, Tasks 01.1–01.5 are the required path. Task 01.6 is a
stretch theorem and may be skipped.

For the Behavior Tree stage, Tasks 02.1–02.4 are the required path. Task 02.5 is
a stretch theorem and may be skipped.

The VDA 5050, uncertainty, and Gemini sections are facilitator-led demos. You do
not need a completed previous exercise to follow them.

## How to continue after the workshop

Use the timestamped files under `playground/backups/` to recover unfinished
work. The reference answers are intentionally not present on the participant
branch; they can be published separately after the session.

## Important Lean detail

During an exercise, later TODO declarations may still show errors while the
specific theorem you are currently editing is already solved. Use the Lean
editor goal/error state for intermediate checkpoints. Run:

```bash
./workshop scenario check
```

at the end of the required part of a scenario, when all baseline Python and Lean
TODOs for that scenario have been completed.

## Rule of thumb

> Preserve your work, move with the room, and return to the proof later.

The workshop is about understanding the verification loop, not winning a proof
speed contest.
