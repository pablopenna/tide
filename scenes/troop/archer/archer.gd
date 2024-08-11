class_name Archer extends Troop

@export var projectile_shooter: ProjectileShooter

func _ready() -> void:
	super._ready()
	self.range = 100

func initialize_with(
	troop_owner: Node2D, 
	position_offset: Vector2, 
	speed: float,
	faction: FactionUtils.Faction
):
	super.initialize_with(troop_owner, position_offset, speed, faction)
	projectile_shooter.projectile_scanned_layer = hitbox_layer
	
