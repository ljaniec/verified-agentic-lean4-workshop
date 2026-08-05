import Mathlib

namespace VerifiedAgenticWorkshop.Robotics

/-- A two-robot wait-for graph represented by its two possible cross edges. -/
structure WaitForState where
  alphaWaitsForBeta : Bool
  betaWaitsForAlpha : Bool
  deriving DecidableEq, Repr

/-- In the two-robot model, deadlock is exactly the directed two-cycle. -/
def Deadlocked (state : WaitForState) : Prop :=
  state.alphaWaitsForBeta = true ∧ state.betaWaitsForAlpha = true

/-- Executable deadlock detector used by the supervisory layer. -/
def detectsDeadlock (state : WaitForState) : Bool :=
  state.alphaWaitsForBeta && state.betaWaitsForAlpha

/-- The executable detector is both sound and complete for this finite model. -/
theorem detectsDeadlock_correct (state : WaitForState) :
    detectsDeadlock state = true ↔ Deadlocked state := by
  rcases state with ⟨alphaWaitsForBeta, betaWaitsForAlpha⟩
  cases alphaWaitsForBeta <;> cases betaWaitsForAlpha <;>
    simp [detectsDeadlock, Deadlocked]

end VerifiedAgenticWorkshop.Robotics
