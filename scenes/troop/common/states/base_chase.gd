class_name ChaseBaseState extends State

var target: Node2D
var target_position_offset: Vector2
var accepted_distance_to_target_position: float = 1
	
#region state transition
# TODO
#endregion	

#region move to target
func _go_to_target_position():
	if _should_move_to_target_position():
		managed_entity.velocity = _get_target_direction() * (managed_entity as Troop).speed
	else:
		managed_entity.velocity = Vector2.ZERO

func _get_target_position() -> Vector2:
	return target.global_position + target_position_offset

func _get_target_direction() -> Vector2:
	return managed_entity.global_position.direction_to(_get_target_position())

func _get_distance_to_target_position() -> float:
	var target_position = _get_target_position()
	var distance = managed_entity.global_position.distance_to(target_position)
	return distance

func _should_move_to_target_position() -> bool:
	if target == null:
		return false
	var distance_to_target_position = _get_distance_to_target_position()
	return distance_to_target_position >= accepted_distance_to_target_position
#endregion
