extends State

@export var follow_leader_state: State
@export var get_in_range_state: State
@export var attack_state: State
var attack_range: int
var target: Node2D

func _ready():
	state_name = "ponder"

func enter(context: Dictionary) -> void:
	attack_range = context.get("range")
	target = context.get("target")

func process(delta: float) -> void:
	if not target:
		change_to_state.emit(follow_leader_state.state_name, {})
	elif managed_entity.global_position.distance_to(target.global_position) > attack_range:
		change_to_state.emit(get_in_range_state.state_name, {
			"target": target,
			"range": attack_range
		})
	else:
		change_to_state.emit(attack_state.state_name, {
			"target": target,
			"range": attack_range
		})
