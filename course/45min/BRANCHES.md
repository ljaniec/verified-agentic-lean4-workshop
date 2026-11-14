# Checkpoint Branch Graph

```text
workshop/00-build
  └─ workshop/00-build-solution
       └─ workshop/01-lifecycle
            └─ workshop/01-lifecycle-solution
                 └─ workshop/02-bt-refinement
                      └─ workshop/02-bt-refinement-solution
                           └─ workshop/03-vda-trace
                                └─ workshop/03-vda-trace-solution
                                     └─ workshop/04-uncertainty
                                          └─ workshop/04-uncertainty-solution
                                               └─ workshop/05-agent-loop
                                                    └─ workshop/05-agent-loop-solution
```

A task branch is always the unsolved checkpoint. A solution branch is always the
verified checkpoint from which the next task begins.

The machine-readable form is `course/45min/tasks.tsv`.
