class_name TargetUtils extends Node

static func has_target(troop: Troop) -> bool:
	return troop.target != null and troop.target != troop.troop_owner

static func is_target_in_range(troop: Troop) -> bool:
	return troop.global_position.distance_to(troop.target.global_position) < troop.range
