import VerifiedAgenticWorkshop.Scenarios.LifecycleResources

namespace VerifiedAgenticWorkshop.Solutions.LifecycleResources

open VerifiedAgenticWorkshop.Scenarios.LifecycleResources

theorem initial_safe : Safe initial := by
  simp [Safe, initial]

theorem buggy_deactivate_breaks_safety :
    Safe activeState ∧ ¬ Safe (buggyStep activeState .deactivate) := by
  simp [Safe, activeState, buggyStep]

theorem step_preserves_safety
    (state : State)
    (event : Event)
    (safe : Safe state) :
    Safe (step state event) := by
  rcases state with ⟨mode, sensorOpen, logOpen, actuatorEnabled⟩
  cases mode <;>
    cases sensorOpen <;>
    cases logOpen <;>
    cases actuatorEnabled <;>
    cases event <;>
    simp [Safe, step, initial, activeState] at safe ⊢

/-- The local invariant lifts from one transition to every finite event trace. -/
theorem run_preserves_safety
    (state : State)
    (events : List Event)
    (safe : Safe state) :
    Safe (run state events) := by
  induction events generalizing state with
  | nil =>
      simpa [run]
  | cons event rest inductionHypothesis =>
      simp only [run]
      exact inductionHypothesis
        (step state event)
        (step_preserves_safety state event safe)

end VerifiedAgenticWorkshop.Solutions.LifecycleResources
