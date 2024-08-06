extends ActionLeaf

@export var animation_player: AnimationPlayer 
var troop: Troop
var accepted_distance_to_target_position: int = 10
	
func before_run(actor: Node, blackboard: Blackboard) -> void:
	troop = actor as Troop
	troop.target = troop.troop_owner
	troop.ordered_to_attack.connect(_on_ordered_to_attack)

func after_run(actor: Node, blackboard: Blackboard) -> void:
	troop.ordered_to_attack.disconnect(_on_ordered_to_attack)
	
func interrupt(actor: Node, blackboard: Blackboard) -> void:
	troop.ordered_to_attack.disconnect(_on_ordered_to_attack)
	
func tick(actor: Node, blackboard: Blackboard) -> int:
	MovementUtils.go_to_target_position(troop, troop.target, troop.following_owner_target_position_offset, accepted_distance_to_target_position)
	_process_animation(actor)
	if(troop.target == null or troop.target == troop.troop_owner):
		return RUNNING
	else:
		return FAILURE

func _on_ordered_to_attack(target: Node2D) -> void:
	troop.target = target

func _process_animation(troop: Troop) -> void:
	if troop.velocity == Vector2.ZERO:
		animation_player.play("idle_down")
	elif troop.facing_direction == Vector2.UP:
		animation_player.play("walk_up")
	elif troop.facing_direction == Vector2.DOWN:
		animation_player.play("walk_down")
	else:
		animation_player.play("walk_right")
