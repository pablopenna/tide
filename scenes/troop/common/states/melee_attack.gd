extends ChaseBaseState

@export var sword: Sword
@export var follow_leader_state: State
@export var get_in_range_state: State

@export var animation_player: AnimationPlayer

var attack_range: int = 14

var attack_cooldown_ms: int = 1000
var last_attack_timestamp: int = 0

func _ready():
	state_name = "melee_attack"
	
func enter(context: Dictionary):
	target = context.get('target')
	managed_entity.velocity = Vector2.ZERO
	sword.target = target
	(managed_entity as Troop).ordered_to_follow_leader.connect(_on_ordered_to_follow_leader)
	
func exit(_new_state: State):
	sword.disable()
	(managed_entity as Troop).ordered_to_follow_leader.disconnect(_on_ordered_to_follow_leader)

func process(_delta):
	### After killing target (and they queue_free()), it will be null
	if target == null: 
		(self.managed_entity as Troop).follow_owner()
	elif managed_entity.global_position.distance_to(target.global_position) > attack_range:
		change_to_state.emit(get_in_range_state.state_name, {
			"target": target,
			"range": attack_range
		})
	_process_animation()

func _on_ordered_to_follow_leader():
	change_to_state.emit(follow_leader_state.state_name, {})

func _process_animation() -> void:
	if managed_entity.facing_direction == Vector2.UP:
		animation_player.play("attack_up")
	elif managed_entity.facing_direction == Vector2.DOWN:
		animation_player.play("attack_down")
	else:
		animation_player.play("attack_right")
