class_name Archer extends Troop

@export var projectile_shooter: ProjectileShooter

func _ready() -> void:
	super._ready()
	self.range = 100

func initialize_with(
	troop_owner: Node2D, 
	hitbox_layer: int, 
	hurtbox_layer: int, 
	position_offset: Vector2, 
	speed: float
):
	super.initialize_with(troop_owner, hitbox_layer, hurtbox_layer, position_offset, speed)
	projectile_shooter.projectile_scanned_layer = hitbox_layer
	
