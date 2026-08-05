import LeanCopilot
import VerifiedAgenticWorkshop.Robotics.Reservations

open VerifiedAgenticWorkshop.Robotics

/-!
Try `select_premises`, then remove the reference theorem and reconstruct the
proof from the definition of `reservationStep`.
-/

example
    {state next : ReservationState}
    {command : ReservationCommand}
    (valid : ReservationValid state)
    (stepped : reservationStep state command = some next) :
    ReservationValid next := by
  exact successful_reservationStep_preserves_validity valid stepped
