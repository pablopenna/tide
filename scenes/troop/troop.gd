class_name Troop extends Entity

var owner_entity: Entity
var target_position_offset: Vector2
var speed: float

signal ordered_to_follow_owner(owner: Entity)
signal ordered_to_attack_target(target: Node2D)

func attack_target(target: Node2D):
	ordered_to_attack_target.emit(target)
	
func follow_owner():
	ordered_to_follow_owner.emit(owner_entity)

func set_hurtbox_layer(layer: int):
	$Hurtbox.collision_layer = layer
	
func set_hitbox_layer(layer: int):
	$Hitbox.collision_mask = layer

func _on_hurtbox_damaged(_hitboxData):
	queue_free()
