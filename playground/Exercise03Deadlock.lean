import LeanCopilot
import VerifiedAgenticWorkshop.Robotics.DeadlockDetector

open VerifiedAgenticWorkshop.Robotics

/-!
Try `suggest_tactics` or `search_proof`. Compare the generated proof with a
manual four-case proof over the two Boolean edges.
-/

example (state : WaitForState) :
    detectsDeadlock state = true ↔ Deadlocked state := by
  exact detectsDeadlock_correct state
