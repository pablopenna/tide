class_name Sword extends Hitbox

@export var troop: Troop
@export var sprite: Sprite2D
var target: Node2D

func _ready() -> void:
	super._ready()
	sprite.visible = false

func enable() -> void:
	super.enable()
	sprite.visible = true

func disable() -> void:
	super.disable()
	sprite.visible = false

func _process(delta) -> void:
	 #super._process(delta)
	#match troop.facing_direction:
		#Vector2.RIGHT:
			#rotation = 0
		#Vector2.UP:
			#rotation = -PI/2
		#Vector2.DOWN:
			#rotation = PI/2
		#Vector2.LEFT:
			#rotation = PI
	if is_enabled and target:
		rotation = global_position.angle_to_point(target.global_position)
