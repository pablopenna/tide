extends ActionLeaf

@export var animation_player: AnimationPlayer
@export var sword: Sword
var troop: Troop

func before_run(actor: Node, blackboard: Blackboard) -> void:
	troop = actor as Troop
	troop.velocity = Vector2.ZERO
	sword.target = troop.target

func after_run(actor: Node, blackboard: Blackboard) -> void:
	animation_player.stop(true)
	sword.disable()

func tick(actor: Node, blackboard: Blackboard) -> int:
	if not TargetUtils.has_target(troop):
		return SUCCESS
	if not TargetUtils.is_target_in_range(troop):
		return FAILURE
	_process_animation()
	return RUNNING

func _process_animation() -> void:
	if troop.facing_direction == Vector2.UP:
		animation_player.play("attack_up")
	elif troop.facing_direction == Vector2.DOWN:
		animation_player.play("attack_down")
	else:
		animation_player.play("attack_right")
