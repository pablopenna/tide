extends Sprite2D

@export var entity: Entity

func _process(delta):
	if entity.facing_direction == Vector2.LEFT:
		set_flip_h(true)
	else:
		set_flip_h(false)
