import Mathlib

namespace VerifiedAgenticWorkshop.Scenarios.PerceptionPlannerContract

structure Interval where
  lo : Int
  hi : Int
  deriving DecidableEq, Repr

def Contains (interval : Interval) (point : Int) : Prop :=
  interval.lo ≤ point ∧ point ≤ interval.hi

def Separated (path obstacle : Interval) : Prop :=
  path.hi < obstacle.lo ∨ obstacle.hi < path.lo

inductive PlannerDecision where
  | accept
  | fallback
  deriving DecidableEq, Repr

/-- Accept only when the path and certified obstacle uncertainty are separated. -/
def decidePlan (path obstacle : Interval) : PlannerDecision :=
  if Separated path obstacle then .accept else .fallback

def separatedPath : Interval := ⟨0, 4⟩
def separatedObstacle : Interval := ⟨7, 10⟩
def overlappingPath : Interval := ⟨0, 8⟩
def overlappingObstacle : Interval := ⟨6, 10⟩

end VerifiedAgenticWorkshop.Scenarios.PerceptionPlannerContract
