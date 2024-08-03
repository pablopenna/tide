class_name Troop extends Entity

@export var state_machine: StateManager
@export var hp_manager: HealthPointsManager

@export var attack_state: State
@export var follow_leader_state: State

var troop_owner: Node2D
var following_owner_target_position_offset: Vector2
var speed: float

var hitbox_layer: int
var hurtbox_layer: int
@export var hurtbox: Hurtbox
@export var hitbox: Hitbox

signal died(troop: Troop)
signal ordered_to_attack(target: Node2D)
signal ordered_to_follow_leader

func _ready() -> void:
	hp_manager.health_zeroed.connect(_on_die)

func initialize_with(troop_owner: Node2D, hitbox_layer: int, hurtbox_layer: int, position_offset: Vector2, speed: float) -> void:
	self.troop_owner = troop_owner
	self.following_owner_target_position_offset = position_offset
	self.speed = speed
	self.set_hitbox_layer(hitbox_layer)
	self.set_hurtbox_layer(hurtbox_layer)
	self.position = troop_owner.position + self.following_owner_target_position_offset

func attack_target(target: Node2D) -> void:
	#state_machine.change_to_state(attack_state.state_name, {target: target})
	ordered_to_attack.emit(target)
	
func follow_owner() -> void:
	#state_machine.change_to_state(follow_leader_state.state_name, {})
	ordered_to_follow_leader.emit()

func set_hurtbox_layer(layer: int) -> void:
	hurtbox_layer = layer
	hurtbox.collision_layer = layer
	
func set_hitbox_layer(layer: int) -> void:
	hitbox_layer = layer
	if hitbox:
		hitbox.collision_mask = layer

func _on_die() -> void:
	died.emit(self)
	queue_free()
