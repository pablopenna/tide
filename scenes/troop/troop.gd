class_name Troop extends Entity

var owner_entity: Entity
var target_position_offset: Vector2
var speed: float

signal followed_owner()
signal attacked_target()
var current_target: Node2D

func attack_target(target: Node2D):
	current_target = target
	attacked_target.emit()
	
func follow_owner():
	followed_owner.emit()
