import Mathlib

namespace VerifiedAgenticWorkshop.Robotics

/-- A compact resource-accounting model for a reservation-based supervisor. -/
structure ReservationState where
  capacity : Nat
  used : Nat
  deriving DecidableEq, Repr

/-- The supervisor never allocates more resource units than physically exist. -/
def ReservationValid (state : ReservationState) : Prop :=
  state.used ≤ state.capacity

inductive ReservationCommand where
  | reserve (units : Nat)
  | release (units : Nat)
  deriving DecidableEq, Repr

/--
A reservation succeeds only when the post-state satisfies the capacity bound.
Release is total because truncated natural subtraction cannot increase usage.
-/
def reservationStep
    (state : ReservationState)
    (command : ReservationCommand) : Option ReservationState :=
  match command with
  | .reserve units =>
      if state.used + units ≤ state.capacity then
        some { state with used := state.used + units }
      else
        none
  | .release units =>
      some { state with used := state.used - units }

/-- Every successful transition preserves the resource-capacity invariant. -/
theorem successful_reservationStep_preserves_validity
    {state next : ReservationState}
    {command : ReservationCommand}
    (valid : ReservationValid state)
    (stepped : reservationStep state command = some next) :
    ReservationValid next := by
  cases command with
  | reserve units =>
      simp only [reservationStep] at stepped
      split at stepped
      · next capacityBound =>
          cases stepped
          exact capacityBound
      · contradiction
  | release units =>
      simp only [reservationStep, Option.some.injEq] at stepped
      cases stepped
      exact le_trans (Nat.sub_le state.used units) valid

/-- A rejected reservation is evidence that the requested post-state is unsafe. -/
theorem rejected_reservation_exceeds_capacity
    {state : ReservationState}
    {units : Nat}
    (rejected : reservationStep state (.reserve units) = none) :
    ¬ state.used + units ≤ state.capacity := by
  simp [reservationStep] at rejected
  exact rejected

end VerifiedAgenticWorkshop.Robotics
