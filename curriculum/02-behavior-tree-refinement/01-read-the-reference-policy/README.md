# Task 02.1 — Read the Reference Policy

**Target time:** 5 minutes

## Objective

Understand the observable semantics before comparing implementations.

## Reference policy

The simplified tree is conceptually:

```text
Fallback [
    Sequence(cancelRequested, stopAndCancel),
    Sequence(goalReached, reportSuccess),
    Sequence(pathAvailable, drive),
    requestPlan
]
```

The first successful branch wins. Therefore cancellation has higher priority
than success reporting, driving, or requesting a plan.

## Inspect

Open:

```text
playground/current/current.py
playground/current/Current.lean
```

In Python, locate `MISSION_TREE`, `Branch`, `tick_fallback`, and `bt_decision`.
The starter now models the branch ordering explicitly instead of hiding the
reference policy inside another handwritten `if` chain.

In Lean, compare the same ideas in the shared Behavior Tree scenario model.
Focus on observable one-tick decisions, not syntax differences between the two
languages.

## Predict before running

What should the reference return for these observations?

```text
cancelRequested=true,  goalReached=false, pathAvailable=true
cancelRequested=false, goalReached=true,  pathAvailable=true
cancelRequested=false, goalReached=false, pathAvailable=true
cancelRequested=false, goalReached=false, pathAvailable=false
```

## Scope

This teaching model represents one observable decision step. It intentionally
omits `RUNNING`, asynchronous nodes, the blackboard, and concurrent subtrees.

## Done when

You can state the priority order of the four decisions and explain how the
Fallback ordering implements it.

## Recovery without the answer

If the tree notation is unfamiliar, ignore the implementation language for one
minute and read the branches top-to-bottom: the first guard that succeeds chooses
its action; if none succeeds, the default is `REQUEST_PLAN`.
