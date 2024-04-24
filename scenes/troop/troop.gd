class_name Troop extends Entity

var troop_owner: Node2D
var target_position_offset: Vector2
var speed: float

@export var state_machine: StateManager

signal died(troop: Troop)

func initialize_with(owner: Node2D, hitbox_layer: int, hurtbox_layer: int, position_offset: Vector2, speed: float):
	self.troop_owner = owner
	self.target_position_offset = position_offset
	self.speed = speed
	self.set_hitbox_layer(hitbox_layer)
	self.set_hurtbox_layer(hurtbox_layer)
	self.position = troop_owner.position + self.target_position_offset

func attack_target(target: Node2D):
	# HACK: prevent changing the state on each frame when detecting enemy
	if state_machine.current_state.state_name != "attack":
		state_machine.change_to_state("attack", {"target": target})
	
func follow_owner():
	state_machine.change_to_state("follow", {"target": troop_owner})

func set_hurtbox_layer(layer: int):
	$Hurtbox.collision_layer = layer
	
func set_hitbox_layer(layer: int):
	$Hitbox.collision_mask = layer

func _on_hurtbox_damaged(_hitboxData):
	died.emit(self)
	queue_free()
