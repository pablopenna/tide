class_name Troop extends Entity

@export var state_machine: StateManager
@export var hp_manager: HealthPointsManager

@export var attack_state: State
@export var follow_leader_state: State

var troop_owner: Node2D
var following_owner_target_position_offset: Vector2
var speed: float

signal died(troop: Troop)
signal ordered_to_attack(target: Node2D)
signal ordered_to_follow_leader

func _ready():
	hp_manager.health_zeroed.connect(_on_die)

func initialize_with(troop_owner: Node2D, hitbox_layer: int, hurtbox_layer: int, position_offset: Vector2, speed: float):
	self.troop_owner = troop_owner
	self.following_owner_target_position_offset = position_offset
	self.speed = speed
	self.set_hitbox_layer(hitbox_layer)
	self.set_hurtbox_layer(hurtbox_layer)
	self.position = troop_owner.position + self.following_owner_target_position_offset

func attack_target(target: Node2D):
	#state_machine.change_to_state(attack_state.state_name, {target: target})
	ordered_to_attack.emit(target)
	
func follow_owner():
	#state_machine.change_to_state(follow_leader_state.state_name, {})
	ordered_to_follow_leader.emit()

func set_hurtbox_layer(layer: int):
	$Hurtbox.collision_layer = layer
	
func set_hitbox_layer(layer: int):
	# HACK: Archers do not have hitboxes in their tree, their projectiles do
	if $Hitbox == null:
		push_warning("Troop has no hitbox: ", self)
		return
	$Hitbox.collision_mask = layer

func _on_die():
	died.emit(self)
	queue_free()
