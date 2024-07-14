extends ChaseBaseState

@export var hitbox: Hitbox
@export var follow_leader_state: State

func _ready():
	state_name = "melee_attack"
	
func enter(context: Dictionary):
	target = context.get('target')
	hitbox.enable()
	(managed_entity as Troop).ordered_to_follow_leader.connect(_on_ordered_to_follow_leader)
	
func exit(_new_state: State):
	hitbox.disable()
	(managed_entity as Troop).ordered_to_follow_leader.disconnect(_on_ordered_to_follow_leader)

func process(_delta):
	### After killing target (and they queue_free()), it will be null
	if target == null: 
		(self.managed_entity as Troop).follow_owner()
		return
	_go_to_target_position()
	
func _on_ordered_to_follow_leader():
	change_to_state.emit(follow_leader_state.state_name, {})
