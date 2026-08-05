import Mathlib

namespace VerifiedAgenticWorkshop.Robotics

/-- Two robots that may attempt to occupy one shared narrow corridor. -/
structure CorridorState where
  alphaInside : Bool
  betaInside : Bool
  deriving DecidableEq, Repr

/-- The physical safety requirement: the two robots are never inside together. -/
def CorridorSafe (state : CorridorState) : Prop :=
  ¬ (state.alphaInside = true ∧ state.betaInside = true)

inductive CorridorCommand where
  | enterAlpha
  | enterBeta
  | leaveAlpha
  | leaveBeta
  deriving DecidableEq, Repr

/-- An intentionally incorrect controller used to demonstrate falsification. -/
def unguardedCorridorStep
    (state : CorridorState) (command : CorridorCommand) : CorridorState :=
  match command with
  | .enterAlpha => { state with alphaInside := true }
  | .enterBeta => { state with betaInside := true }
  | .leaveAlpha => { state with alphaInside := false }
  | .leaveBeta => { state with betaInside := false }

/-- The corrected controller refuses an entry command while the other robot is inside. -/
def guardedCorridorStep
    (state : CorridorState) (command : CorridorCommand) : CorridorState :=
  match command with
  | .enterAlpha =>
      if state.betaInside then state else { state with alphaInside := true }
  | .enterBeta =>
      if state.alphaInside then state else { state with betaInside := true }
  | .leaveAlpha => { state with alphaInside := false }
  | .leaveBeta => { state with betaInside := false }

/-- A concrete counterexample to the false claim that every entry controller is safe. -/
theorem unguarded_enterAlpha_can_break_safety :
    ∃ state,
      CorridorSafe state ∧
      ¬ CorridorSafe (unguardedCorridorStep state .enterAlpha) := by
  refine ⟨⟨false, true⟩, ?_, ?_⟩
  · simp [CorridorSafe]
  · simp [CorridorSafe, unguardedCorridorStep]

/-- The guard is sufficient to preserve the corridor invariant. -/
theorem guardedCorridorStep_preserves_safety
    (state : CorridorState)
    (command : CorridorCommand)
    (safe : CorridorSafe state) :
    CorridorSafe (guardedCorridorStep state command) := by
  rcases state with ⟨alphaInside, betaInside⟩
  cases alphaInside <;> cases betaInside <;> cases command <;>
    simp [CorridorSafe, guardedCorridorStep] at safe ⊢

end VerifiedAgenticWorkshop.Robotics
