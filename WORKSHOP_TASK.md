# Task 04 — Perception-Planner Uncertainty Contract

**Timebox: 6 minutes**

## Goal

Show that a point estimate can look safe while the certified uncertainty set
still overlaps the path.

## Start

```bash
./workshop task start
```

The executable Python example is already complete.

## Work

Read the concrete values:

```text
path          [0, 8]
point         10
uncertainty   [6, 10]
```

Then complete only the Lean theorem
`point_estimate_can_miss_uncertainty`.

## Claim boundary

The theorem reasons relative to the supplied uncertainty interval. It does not
prove that the real obstacle is inside that interval.

## Done

```bash
./workshop task check
```

Stop at `WORKSHOP_TASK_OK 04-uncertainty`, then run
`./workshop task next`.
