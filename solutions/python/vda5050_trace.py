from __future__ import annotations

from dataclasses import dataclass, replace
from enum import Enum, auto
from typing import TypeAlias


@dataclass(frozen=True)
class OrderMessage:
    order_id: int
    order_update_id: int


@dataclass(frozen=True)
class StateMessage:
    order_id: int
    last_node_sequence_id: int


Message: TypeAlias = OrderMessage | StateMessage


@dataclass(frozen=True)
class Monitor:
    current_order: int | None = None
    last_order_update_id: int = 0
    last_node_sequence_id: int = 0


class Violation(Enum):
    FIRST_ORDER_UPDATE_MUST_BE_ZERO = auto()
    ORDER_UPDATE_NOT_INCREASING = auto()
    NEW_ORDER_MUST_START_AT_ZERO = auto()
    STATE_WITHOUT_ORDER = auto()
    STATE_ORDER_MISMATCH = auto()
    NODE_SEQUENCE_REGRESSED = auto()


@dataclass(frozen=True)
class StepResult:
    monitor: Monitor | None
    violation: Violation | None

    @property
    def accepted(self) -> bool:
        return self.violation is None


@dataclass(frozen=True)
class TraceResult:
    monitor: Monitor | None
    violation: Violation | None
    rejected_index: int | None

    @property
    def accepted(self) -> bool:
        return self.violation is None


def check_step(monitor: Monitor, message: Message) -> StepResult:
    if isinstance(message, OrderMessage):
        if monitor.current_order is None:
            if message.order_update_id != 0:
                return StepResult(None, Violation.FIRST_ORDER_UPDATE_MUST_BE_ZERO)
            return StepResult(Monitor(current_order=message.order_id), None)

        if message.order_id == monitor.current_order:
            if message.order_update_id <= monitor.last_order_update_id:
                return StepResult(None, Violation.ORDER_UPDATE_NOT_INCREASING)
            return StepResult(
                replace(monitor, last_order_update_id=message.order_update_id), None
            )

        if message.order_update_id != 0:
            return StepResult(None, Violation.NEW_ORDER_MUST_START_AT_ZERO)
        return StepResult(Monitor(current_order=message.order_id), None)

    if monitor.current_order is None:
        return StepResult(None, Violation.STATE_WITHOUT_ORDER)
    if message.order_id != monitor.current_order:
        return StepResult(None, Violation.STATE_ORDER_MISMATCH)
    if message.last_node_sequence_id < monitor.last_node_sequence_id:
        return StepResult(None, Violation.NODE_SEQUENCE_REGRESSED)
    return StepResult(
        replace(monitor, last_node_sequence_id=message.last_node_sequence_id), None
    )


def step(monitor: Monitor, message: Message) -> Monitor | None:
    return check_step(monitor, message).monitor


def run_detailed(trace: list[Message]) -> TraceResult:
    monitor = Monitor()
    for index, message in enumerate(trace):
        result = check_step(monitor, message)
        if not result.accepted:
            return TraceResult(None, result.violation, index)
        assert result.monitor is not None
        monitor = result.monitor
    return TraceResult(monitor, None, None)


def run(trace: list[Message]) -> Monitor | None:
    return run_detailed(trace).monitor


VALID_TRACE: list[Message] = [
    OrderMessage(7, 0),
    StateMessage(7, 2),
    OrderMessage(7, 1),
    StateMessage(7, 4),
]

STALE_UPDATE_TRACE: list[Message] = [
    OrderMessage(7, 0),
    OrderMessage(7, 0),
]

REGRESSING_STATE_TRACE: list[Message] = [
    OrderMessage(7, 0),
    StateMessage(7, 4),
    StateMessage(7, 3),
]


def main() -> None:
    assert run(VALID_TRACE) == Monitor(7, 1, 4)
    assert run_detailed(STALE_UPDATE_TRACE) == TraceResult(
        None, Violation.ORDER_UPDATE_NOT_INCREASING, 1
    )
    assert run_detailed(REGRESSING_STATE_TRACE) == TraceResult(
        None, Violation.NODE_SEQUENCE_REGRESSED, 2
    )
    print("vda5050_trace: all reference checks passed")


if __name__ == "__main__":
    main()
