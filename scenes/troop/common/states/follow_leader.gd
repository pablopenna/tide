extends ChaseBaseState

@export var attack_state: State

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
	
func _on_ordered_to_attack(target: Node2D) -> void:
	print("changing to target; ", target)
	change_to_state.emit(attack_state.state_name, {'target': target})
