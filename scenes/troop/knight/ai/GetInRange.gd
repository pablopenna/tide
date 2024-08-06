extends ActionLeaf

@export var animation_player: AnimationPlayer
var troop: Troop
var accepted_distance_to_target_position: int = 10

func before_run(actor: Node, blackboard: Blackboard) -> void:
	troop = actor as Troop

func tick(actor: Node, blackboard: Blackboard) -> int:
	if not TargetUtils.has_target(troop):
		return FAILURE
	if not TargetUtils.is_target_in_range(troop):
		_process_animation()
		MovementUtils.go_to_target_position(troop, troop.target, Vector2.ZERO, accepted_distance_to_target_position)
		return RUNNING
	return SUCCESS

func _process_animation() -> void:
	if troop.velocity == Vector2.ZERO:
		animation_player.play("idle_down")
	elif troop.facing_direction == Vector2.UP:
		animation_player.play("walk_up")
	elif troop.facing_direction == Vector2.DOWN:
		animation_player.play("walk_down")
	else:
		animation_player.play("walk_right")
