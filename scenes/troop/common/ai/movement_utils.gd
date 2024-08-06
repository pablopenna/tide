class_name MovementUtils extends Node

static func go_to_target_position(
	actor: Troop,
	target: Node2D,
	target_position_offset: Vector2,
	accepted_distance_to_target_position: int = 1,
) -> void:
	if _should_move_to_target_position(actor, target, target_position_offset, accepted_distance_to_target_position):
		actor.velocity = _get_target_direction(actor, target, target_position_offset) * actor.speed
	else:
		actor.velocity = Vector2.ZERO

static func _get_target_position(
	target: Node2D,
	target_position_offset: Vector2,
) -> Vector2:
	return target.global_position + target_position_offset

static func _get_target_direction(
	actor: Troop,
	target: Node2D,
	target_position_offset: Vector2,
) -> Vector2:
	return actor.global_position.direction_to(_get_target_position(target, target_position_offset))

static func _get_distance_to_target_position(
	actor: Troop,
	target: Node2D,
	target_position_offset: Vector2,
) -> float:
	var target_position: Vector2 = _get_target_position(target, target_position_offset)
	var distance: float = actor.global_position.distance_to(target_position)
	return distance

static func _should_move_to_target_position(
	actor: Troop,
	target: Node2D,
	target_position_offset: Vector2,
	accepted_distance_to_target_position: int
) -> bool:
	if target == null:
		return false
	var distance_to_target_position: float = _get_distance_to_target_position(actor, target, target_position_offset)
	return distance_to_target_position >= accepted_distance_to_target_position
