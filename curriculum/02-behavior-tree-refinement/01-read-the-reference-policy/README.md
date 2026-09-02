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

Open the Python and Lean files for the active `bt` scenario. Locate the
observation type and the reference decision function.

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

You can state the priority order of the four decisions without reading the
implementation.
