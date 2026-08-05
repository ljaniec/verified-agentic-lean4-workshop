import VerifiedAgenticWorkshop.Scenarios.PerceptionPlannerContract

namespace VerifiedAgenticWorkshop.Solutions.PerceptionPlannerContract

open VerifiedAgenticWorkshop.Scenarios.PerceptionPlannerContract

theorem separated_example_accepted :
    decidePlan separatedPath separatedObstacle = .accept := by
  decide

theorem overlapping_example_falls_back :
    decidePlan overlappingPath overlappingObstacle = .fallback := by
  decide

theorem accept_implies_no_collision
    (path obstacle : Interval)
    (accepted : decidePlan path obstacle = .accept) :
    ∀ pathPoint obstaclePoint,
      Contains path pathPoint →
      Contains obstacle obstaclePoint →
      pathPoint ≠ obstaclePoint := by
  have separated : Separated path obstacle := by
    by_contra notSeparated
    simp [decidePlan, notSeparated] at accepted
  intro pathPoint obstaclePoint pathContains obstacleContains equalPoints
  rcases separated with pathBeforeObstacle | obstacleBeforePath
  · omega
  · omega

end VerifiedAgenticWorkshop.Solutions.PerceptionPlannerContract
