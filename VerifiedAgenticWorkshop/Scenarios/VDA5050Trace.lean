import Mathlib

namespace VerifiedAgenticWorkshop.Scenarios.VDA5050Trace

/-!
A deliberately small teaching profile inspired by VDA 5050 3.0. It is not a
complete implementation of the standard. It demonstrates the gap between
validating one message and validating a temporal message trace.
-/

structure OrderMessage where
  orderId : Nat
  orderUpdateId : Nat
  deriving DecidableEq, Repr

structure StateMessage where
  orderId : Nat
  lastNodeSequenceId : Nat
  deriving DecidableEq, Repr

inductive Message where
  | order (message : OrderMessage)
  | state (message : StateMessage)
  deriving DecidableEq, Repr

structure Monitor where
  currentOrder : Option Nat
  lastOrderUpdateId : Nat
  lastNodeSequenceId : Nat
  deriving DecidableEq, Repr

def initial : Monitor :=
  ⟨none, 0, 0⟩

/--
The local teaching policy checks new-order initialization, increasing updates,
matching order identifiers, and nondecreasing reported node progress.
-/
def step (monitor : Monitor) (message : Message) : Option Monitor :=
  match message with
  | .order orderMessage =>
      match monitor.currentOrder with
      | none =>
          if orderMessage.orderUpdateId = 0 then
            some ⟨some orderMessage.orderId, 0, 0⟩
          else
            none
      | some currentOrder =>
          if orderMessage.orderId = currentOrder then
            if monitor.lastOrderUpdateId < orderMessage.orderUpdateId then
              some { monitor with
                lastOrderUpdateId := orderMessage.orderUpdateId }
            else
              none
          else if orderMessage.orderUpdateId = 0 then
            some ⟨some orderMessage.orderId, 0, 0⟩
          else
            none
  | .state stateMessage =>
      match monitor.currentOrder with
      | none => none
      | some currentOrder =>
          if stateMessage.orderId = currentOrder ∧
              monitor.lastNodeSequenceId ≤ stateMessage.lastNodeSequenceId then
            some { monitor with
              lastNodeSequenceId := stateMessage.lastNodeSequenceId }
          else
            none

def run : Monitor → List Message → Option Monitor
  | monitor, [] => some monitor
  | monitor, message :: rest =>
      match step monitor message with
      | none => none
      | some next => run next rest

def validTrace : List Message :=
  [ .order ⟨7, 0⟩,
    .state ⟨7, 2⟩,
    .order ⟨7, 1⟩,
    .state ⟨7, 4⟩ ]

def staleUpdateTrace : List Message :=
  [ .order ⟨7, 0⟩,
    .order ⟨7, 0⟩ ]

def regressingStateTrace : List Message :=
  [ .order ⟨7, 0⟩,
    .state ⟨7, 4⟩,
    .state ⟨7, 3⟩ ]

end VerifiedAgenticWorkshop.Scenarios.VDA5050Trace
