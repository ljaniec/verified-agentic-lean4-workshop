import LeanCopilot
import VerifiedAgenticWorkshop.Robotics.Corridor

open VerifiedAgenticWorkshop.Robotics

/-!
Delete the final proof line and ask Lean Copilot for suggestions.
Do not accept a proposal until this file compiles.
-/

example
    (state : CorridorState)
    (command : CorridorCommand)
    (safe : CorridorSafe state) :
    CorridorSafe (guardedCorridorStep state command) := by
  exact guardedCorridorStep_preserves_safety state command safe
