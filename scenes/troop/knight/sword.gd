extends Hitbox

@export var troop: Troop

func _ready() -> void:
	super._ready()

func _process(delta) -> void:
	# super._process(delta)
	match troop.facing_direction:
		Vector2.RIGHT:
			rotation = 0
		Vector2.UP:
			rotation = -PI/2
		Vector2.DOWN:
			rotation = PI/2
		Vector2.LEFT:
			rotation = PI
