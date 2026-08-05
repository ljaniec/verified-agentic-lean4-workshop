from __future__ import annotations

from dataclasses import dataclass
from enum import Enum, auto
from itertools import product


class Mode(Enum):
    UNCONFIGURED = auto()
    INACTIVE = auto()
    ACTIVE = auto()
    FINALIZED = auto()


class Event(Enum):
    CONFIGURE = auto()
    ACTIVATE = auto()
    DEACTIVATE = auto()
    CLEANUP = auto()
    SHUTDOWN = auto()
    RECOVER_FROM_ERROR = auto()


@dataclass(frozen=True)
class State:
    mode: Mode
    sensor_open: bool
    log_open: bool
    actuator_enabled: bool


INITIAL = State(Mode.UNCONFIGURED, False, False, False)
ACTIVE_STATE = State(Mode.ACTIVE, True, True, True)


def safe(state: State) -> bool:
    active_resources = state.mode is not Mode.ACTIVE or (
        state.sensor_open and state.log_open
    )
    actuator_guard = not state.actuator_enabled or state.mode is Mode.ACTIVE
    terminal_cleanup = state.mode not in {Mode.UNCONFIGURED, Mode.FINALIZED} or (
        not state.sensor_open
        and not state.log_open
        and not state.actuator_enabled
    )
    return active_resources and actuator_guard and terminal_cleanup


def buggy_step(state: State, event: Event) -> State:
    if state.mode is Mode.UNCONFIGURED and event is Event.CONFIGURE:
        return State(Mode.INACTIVE, False, False, False)
    if state.mode is Mode.INACTIVE and event is Event.ACTIVATE:
        return ACTIVE_STATE
    if state.mode is Mode.ACTIVE and event is Event.DEACTIVATE:
        return State(
            Mode.INACTIVE,
            state.sensor_open,
            state.log_open,
            state.actuator_enabled,
        )
    if state.mode is Mode.INACTIVE and event is Event.CLEANUP:
        return INITIAL
    if event is Event.SHUTDOWN:
        return State(Mode.FINALIZED, False, False, False)
    if event is Event.RECOVER_FROM_ERROR:
        return INITIAL
    return state


def step(state: State, event: Event) -> State:
    if state.mode is Mode.UNCONFIGURED and event is Event.CONFIGURE:
        return State(Mode.INACTIVE, False, False, False)
    if state.mode is Mode.INACTIVE and event is Event.ACTIVATE:
        return ACTIVE_STATE
    if state.mode is Mode.ACTIVE and event is Event.DEACTIVATE:
        return State(Mode.INACTIVE, False, False, False)
    if state.mode is Mode.INACTIVE and event is Event.CLEANUP:
        return INITIAL
    if event is Event.SHUTDOWN:
        return State(Mode.FINALIZED, False, False, False)
    if event is Event.RECOVER_FROM_ERROR:
        return INITIAL
    return state


def all_states() -> list[State]:
    return [
        State(mode, sensor, log, actuator)
        for mode, sensor, log, actuator in product(
            Mode, (False, True), (False, True), (False, True)
        )
    ]


def preservation_holds() -> bool:
    return all(
        safe(step(state, event))
        for state in all_states()
        if safe(state)
        for event in Event
    )


def main() -> None:
    assert safe(INITIAL)
    assert safe(ACTIVE_STATE)
    assert not safe(buggy_step(ACTIVE_STATE, Event.DEACTIVATE))
    assert preservation_holds()
    print("lifecycle_resources: all reference checks passed")


if __name__ == "__main__":
    main()
