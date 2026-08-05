import VerifiedAgenticWorkshop.Scenarios.BehaviorTreeRefinement

namespace VerifiedAgenticWorkshop.Solutions.BehaviorTreeRefinement

open VerifiedAgenticWorkshop.Scenarios.BehaviorTreeRefinement

theorem buggy_refactoring_counterexample :
    buggyFsmDecision cancelWhilePathAvailable ≠
      btDecision cancelWhilePathAvailable := by
  decide

theorem corrected_fsm_matches_bt (observation : Observation) :
    fsmDecision observation = btDecision observation := by
  rcases observation with ⟨cancelRequested, goalReached, pathAvailable⟩
  cases cancelRequested <;>
    cases goalReached <;>
    cases pathAvailable <;>
    rfl

end VerifiedAgenticWorkshop.Solutions.BehaviorTreeRefinement
