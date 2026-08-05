from solutions.python.behavior_tree_refinement import (
    Observation,
    all_observations,
    bt_decision,
    buggy_fsm_decision,
    fsm_decision,
)
from solutions.python.lifecycle_resources import (
    ACTIVE_STATE,
    Event,
    buggy_step,
    preservation_holds,
    safe,
)
from solutions.python.perception_planner_contract import (
    Interval,
    PlannerDecision,
    accepted_plan_is_collision_free,
    decide_plan,
)
from solutions.python.vda5050_trace import (
    REGRESSING_STATE_TRACE,
    STALE_UPDATE_TRACE,
    VALID_TRACE,
    Monitor,
    run,
)


def test_lifecycle_reference_solution() -> None:
    assert not safe(buggy_step(ACTIVE_STATE, Event.DEACTIVATE))
    assert preservation_holds()


def test_bt_refinement_reference_solution() -> None:
    counterexample = Observation(True, False, True)
    assert buggy_fsm_decision(counterexample) != bt_decision(counterexample)
    assert all(fsm_decision(obs) == bt_decision(obs) for obs in all_observations())


def test_vda5050_trace_reference_solution() -> None:
    assert run(VALID_TRACE) == Monitor(7, 1, 4)
    assert run(STALE_UPDATE_TRACE) is None
    assert run(REGRESSING_STATE_TRACE) is None


def test_perception_planner_reference_solution() -> None:
    path = Interval(0, 4)
    obstacle = Interval(7, 10)
    assert decide_plan(path, obstacle) is PlannerDecision.ACCEPT
    assert accepted_plan_is_collision_free(path, obstacle)
    assert (
        decide_plan(Interval(0, 8), Interval(6, 10))
        is PlannerDecision.FALLBACK
    )
