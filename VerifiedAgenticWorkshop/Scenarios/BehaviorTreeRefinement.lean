import Mathlib

namespace VerifiedAgenticWorkshop.Scenarios.BehaviorTreeRefinement

structure Observation where
  cancelRequested : Bool
  goalReached : Bool
  pathAvailable : Bool
  deriving DecidableEq, Repr

inductive Decision where
  | stopAndCancel
  | reportSuccess
  | drive
  | requestPlan
  deriving DecidableEq, Repr

inductive Condition where
  | cancelRequested
  | goalReached
  | pathAvailable
  deriving DecidableEq, Repr

/-- One child of a simplified Fallback of condition-action Sequences. -/
structure Branch where
  guard : Condition
  action : Decision
  deriving DecidableEq, Repr

def conditionHolds (condition : Condition) (observation : Observation) : Bool :=
  match condition with
  | .cancelRequested => observation.cancelRequested
  | .goalReached => observation.goalReached
  | .pathAvailable => observation.pathAvailable

def tickFallback
    (branches : List Branch)
    (defaultDecision : Decision)
    (observation : Observation) : Decision :=
  match branches with
  | [] => defaultDecision
  | branch :: rest =>
      if conditionHolds branch.guard observation then
        branch.action
      else
        tickFallback rest defaultDecision observation

def missionTree : List Branch :=
  [ ⟨.cancelRequested, .stopAndCancel⟩,
    ⟨.goalReached, .reportSuccess⟩,
    ⟨.pathAvailable, .drive⟩ ]

def btDecision (observation : Observation) : Decision :=
  tickFallback missionTree .requestPlan observation

/-- Deliberate refactoring bug: navigation has priority over cancellation. -/
def buggyFsmDecision (observation : Observation) : Decision :=
  if observation.pathAvailable then
    .drive
  else if observation.cancelRequested then
    .stopAndCancel
  else if observation.goalReached then
    .reportSuccess
  else
    .requestPlan

def fsmDecision (observation : Observation) : Decision :=
  if observation.cancelRequested then
    .stopAndCancel
  else if observation.goalReached then
    .reportSuccess
  else if observation.pathAvailable then
    .drive
  else
    .requestPlan

def cancelWhilePathAvailable : Observation :=
  ⟨true, false, true⟩

end VerifiedAgenticWorkshop.Scenarios.BehaviorTreeRefinement
