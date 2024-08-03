extends ChaseBaseState

@export var attack_state: State
@export var animation_player: AnimationPlayer

func _ready() -> void:
	state_name = "follow_leader"
	
func enter(context) -> void:
	target = (managed_entity as Troop).troop_owner
	target_position_offset = (managed_entity as Troop).following_owner_target_position_offset
	# HACK: cannot be in _ready as managed_entity is null when it is called
	(managed_entity as Troop).ordered_to_attack.connect(_on_ordered_to_attack)

func exit(_new_state: State) -> void:
	(managed_entity as Troop).ordered_to_attack.disconnect(_on_ordered_to_attack)
	
func process(delta) -> void:
	_go_to_target_position()
	_process_animation()
	
func _on_ordered_to_attack(target: Node2D) -> void:
	print("changing to target; ", target)
	change_to_state.emit(attack_state.state_name, {'target': target})

func _process_animation() -> void:
	if managed_entity.velocity == Vector2.ZERO:
		animation_player.play("idle_down")
	elif managed_entity.facing_direction == Vector2.UP:
		animation_player.play("walk_up")
	elif managed_entity.facing_direction == Vector2.DOWN:
		animation_player.play("walk_down")
	else:
		animation_player.play("walk_right")
