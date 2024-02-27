class_name Troop extends Entity

@export var entity_to_follow: Entity
var target_position_offset: Vector2
const TARGET_POSITION_ACCEPTED_DISTANCE: float = 1
var speed: float
	
func process(_delta):
	if _should_move_to_target_position():
		velocity = _get_target_direction() * speed
	else:
		velocity = Vector2.ZERO

func _get_target_position() -> Vector2:
	return entity_to_follow.position + target_position_offset

func _get_target_direction() -> Vector2:
	return position.direction_to(_get_target_position())

func _get_distance_to_target_position() -> float:
	var target_position = _get_target_position()
	return position.distance_to(target_position)

func _should_move_to_target_position() -> bool:
	return _get_distance_to_target_position() >= TARGET_POSITION_ACCEPTED_DISTANCE
