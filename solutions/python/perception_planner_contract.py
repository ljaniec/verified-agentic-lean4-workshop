from __future__ import annotations

from dataclasses import dataclass
from enum import Enum, auto


@dataclass(frozen=True)
class Interval:
    lo: int
    hi: int

    def contains(self, point: int) -> bool:
        return self.lo <= point <= self.hi


class PlannerDecision(Enum):
    ACCEPT = auto()
    FALLBACK = auto()


def separated(path: Interval, obstacle: Interval) -> bool:
    return path.hi < obstacle.lo or obstacle.hi < path.lo


def decide_plan(path: Interval, obstacle: Interval) -> PlannerDecision:
    if separated(path, obstacle):
        return PlannerDecision.ACCEPT
    return PlannerDecision.FALLBACK


def accepted_plan_is_collision_free(path: Interval, obstacle: Interval) -> bool:
    if decide_plan(path, obstacle) is not PlannerDecision.ACCEPT:
        return True
    path_points = range(path.lo, path.hi + 1)
    obstacle_points = range(obstacle.lo, obstacle.hi + 1)
    return all(
        path_point != obstacle_point
        for path_point in path_points
        for obstacle_point in obstacle_points
    )


def main() -> None:
    separated_path = Interval(0, 4)
    separated_obstacle = Interval(7, 10)
    overlapping_path = Interval(0, 8)
    overlapping_obstacle = Interval(6, 10)

    assert decide_plan(separated_path, separated_obstacle) is PlannerDecision.ACCEPT
    assert (
        decide_plan(overlapping_path, overlapping_obstacle)
        is PlannerDecision.FALLBACK
    )
    assert accepted_plan_is_collision_free(separated_path, separated_obstacle)
    print("perception_planner_contract: all reference checks passed")


if __name__ == "__main__":
    main()
