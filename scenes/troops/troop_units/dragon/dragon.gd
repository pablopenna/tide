class_name Dragon extends Troop

@export var projectile_shooter: ProjectileShooter

func _ready():
	troop_type = TroopTypes.Type.DRAGON
	super._ready()

func initialize_with(
	troop_owner: Node2D, 
	position_offset: Vector2, 
	faction: FactionUtils.Faction
):
	super.initialize_with(troop_owner, position_offset, faction)
	projectile_shooter.projectile_scanned_layer = hitbox_layer
