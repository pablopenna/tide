extends State

const TARGET_POSITION_ACCEPTED_DISTANCE: float = 1
var target: Node2D

func _ready():
	state_name = "attack"
	
func enter(context: Dictionary):
	target = context.get('target')

func process(_delta):
	### After killing target (and they queue_free()), it will be null
	if target == null: 
		change_to_state.emit("follow", {})
		return
		
	if _should_move_to_target_position():
		managed_entity.velocity = _get_target_direction() * managed_entity.speed
	else:
		managed_entity.velocity = Vector2.ZERO

func _get_target_position() -> Vector2:
	return target.global_position

func _get_target_direction() -> Vector2:
	return managed_entity.position.direction_to(_get_target_position())

func _get_distance_to_target_position() -> float:
	var target_position = _get_target_position()
	return managed_entity.position.distance_to(target_position)

func _should_move_to_target_position() -> bool:
	return _get_distance_to_target_position() >= TARGET_POSITION_ACCEPTED_DISTANCE

func _on_troop_ordered_to_follow_owner(owner):
	change_to_state.emit("follow", {})
