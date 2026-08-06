from solutions.python.behavior_tree_refinement import (
    Decision,
    Observation,
    all_observations,
    bt_decision,
    buggy_fsm_decision,
    decision_trace,
    fsm_decision,
)
from solutions.python.lifecycle_resources import (
    ACTIVE_STATE,
    INITIAL,
    Event,
    buggy_step,
    preservation_holds,
    run as run_lifecycle,
    safe,
)
from solutions.python.perception_planner_contract import (
    Interval,
    PlannerDecision,
    accepted_plan_is_collision_free,
    decide_from_point_estimate,
    decide_plan,
)
from solutions.python.vda5050_trace import (
    REGRESSING_STATE_TRACE,
    STALE_UPDATE_TRACE,
    VALID_TRACE,
    Monitor,
    TraceResult,
    Violation,
    run,
    run_detailed,
)


def test_lifecycle_reference_solution() -> None:
    assert not safe(buggy_step(ACTIVE_STATE, Event.DEACTIVATE))
    assert preservation_holds()
    assert safe(
        run_lifecycle(
            INITIAL,
            [Event.CONFIGURE, Event.ACTIVATE, Event.DEACTIVATE, Event.CLEANUP],
        )
    )


def test_bt_refinement_reference_solution() -> None:
    counterexample = Observation(True, False, True)
    trace = [Observation(False, False, True), counterexample]
    assert buggy_fsm_decision(counterexample) != bt_decision(counterexample)
    assert all(fsm_decision(obs) == bt_decision(obs) for obs in all_observations())
    assert decision_trace(fsm_decision, trace) == decision_trace(bt_decision, trace)
    assert decision_trace(bt_decision, [counterexample]) == [Decision.STOP_AND_CANCEL]


def test_vda5050_trace_reference_solution() -> None:
    assert run(VALID_TRACE) == Monitor(7, 1, 4)
    assert run_detailed(STALE_UPDATE_TRACE) == TraceResult(
        None, Violation.ORDER_UPDATE_NOT_INCREASING, 1
    )
    assert run_detailed(REGRESSING_STATE_TRACE) == TraceResult(
        None, Violation.NODE_SEQUENCE_REGRESSED, 2
    )


def test_perception_planner_reference_solution() -> None:
    path = Interval(0, 4)
    obstacle = Interval(7, 10)
    uncertain_path = Interval(0, 8)
    uncertain_obstacle = Interval(6, 10)
    assert decide_plan(path, obstacle) is PlannerDecision.ACCEPT
    assert accepted_plan_is_collision_free(path, obstacle)
    assert decide_plan(uncertain_path, uncertain_obstacle) is PlannerDecision.FALLBACK
    assert (
        decide_from_point_estimate(uncertain_path, 10) is PlannerDecision.ACCEPT
    )
