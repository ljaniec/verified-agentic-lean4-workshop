import LeanCopilot
import VerifiedAgenticWorkshop.Robotics.Corridor
import VerifiedAgenticWorkshop.Robotics.Reservations
import VerifiedAgenticWorkshop.Robotics.DeadlockDetector

namespace VerifiedAgenticWorkshop.Workshop

open VerifiedAgenticWorkshop.Robotics

/-!
# Lean Copilot workshop examples

For each theorem below, participants can temporarily delete the reference proof
and try one or more interactive commands:

* `suggest_tactics`
* `search_proof`
* `select_premises`

The committed version remains fully checked so that `lake build` is always a
reliable local acceptance gate.
-/

/-- Exercise 1: recover the guard-preservation proof. -/
theorem exercise_guarded_corridor
    (state : CorridorState)
    (command : CorridorCommand)
    (safe : CorridorSafe state) :
    CorridorSafe (guardedCorridorStep state command) := by
  exact guardedCorridorStep_preserves_safety state command safe

/-- Exercise 2: recover the reservation invariant after a successful step. -/
theorem exercise_reservation_invariant
    {state next : ReservationState}
    {command : ReservationCommand}
    (valid : ReservationValid state)
    (stepped : reservationStep state command = some next) :
    ReservationValid next := by
  exact successful_reservationStep_preserves_validity valid stepped

/-- Exercise 3: connect the executable detector to its logical specification. -/
theorem exercise_deadlock_detector (state : WaitForState) :
    detectsDeadlock state = true ↔ Deadlocked state := by
  exact detectsDeadlock_correct state

end VerifiedAgenticWorkshop.Workshop
