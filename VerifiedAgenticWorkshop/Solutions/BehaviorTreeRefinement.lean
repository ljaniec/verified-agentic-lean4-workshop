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

/-- Pointwise equivalence lifts to every finite observable execution trace. -/
theorem corrected_fsm_trace_matches_bt (observations : List Observation) :
    decisionTrace fsmDecision observations =
      decisionTrace btDecision observations := by
  simp [decisionTrace, corrected_fsm_matches_bt]

end VerifiedAgenticWorkshop.Solutions.BehaviorTreeRefinement
