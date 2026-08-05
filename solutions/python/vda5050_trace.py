from __future__ import annotations

from dataclasses import dataclass, replace
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


def step(monitor: Monitor, message: Message) -> Monitor | None:
    if isinstance(message, OrderMessage):
        if monitor.current_order is None:
            if message.order_update_id != 0:
                return None
            return Monitor(current_order=message.order_id)

        if message.order_id == monitor.current_order:
            if message.order_update_id <= monitor.last_order_update_id:
                return None
            return replace(monitor, last_order_update_id=message.order_update_id)

        if message.order_update_id != 0:
            return None
        return Monitor(current_order=message.order_id)

    if monitor.current_order is None:
        return None
    if message.order_id != monitor.current_order:
        return None
    if message.last_node_sequence_id < monitor.last_node_sequence_id:
        return None
    return replace(monitor, last_node_sequence_id=message.last_node_sequence_id)


def run(trace: list[Message]) -> Monitor | None:
    monitor = Monitor()
    for message in trace:
        next_monitor = step(monitor, message)
        if next_monitor is None:
            return None
        monitor = next_monitor
    return monitor


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
    assert run(STALE_UPDATE_TRACE) is None
    assert run(REGRESSING_STATE_TRACE) is None
    print("vda5050_trace: all reference checks passed")


if __name__ == "__main__":
    main()
