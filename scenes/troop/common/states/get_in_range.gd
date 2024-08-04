extends ChaseBaseState

var range: float
@export var shoot_state: State
@export var follow_leader_state: State

@export var animation_player: AnimationPlayer

func _ready():
	state_name = "get_in_range"

func enter(context: Dictionary):
	target = context.get("target")
	range = context.get("range")

func process(_delta):
	# Target can die, when so, it will be freed and its value considered null
	if target == null:
		change_to_state.emit(follow_leader_state.state_name, {})
		return
	if _is_target_in_range():
		change_to_state.emit(shoot_state.state_name, {"target": target})
		return
	_go_to_target_position()
	_process_animation()

func _is_target_in_range() -> bool:
	return managed_entity.global_position.distance_to(target.global_position) < range

func _process_animation() -> void:
	if managed_entity.velocity == Vector2.ZERO:
		animation_player.play("idle_down")
	elif managed_entity.facing_direction == Vector2.UP:
		animation_player.play("walk_up")
	elif managed_entity.facing_direction == Vector2.DOWN:
		animation_player.play("walk_down")
	else:
		animation_player.play("walk_right")
