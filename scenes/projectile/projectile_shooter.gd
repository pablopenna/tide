class_name ProjectileShooter extends Node2D

@export var projectileScene: PackedScene
var projectile_scanned_layer: int
	
func shoot(
	initial_position: Vector2,
	direction: Vector2, 
	speed: float
):
	var projectile = projectileScene.instantiate() as Projectile
	
	# projectile.collision_layer = projectile_layer
	projectile.collision_mask = self.projectile_scanned_layer
	projectile.direction = direction
	projectile.speed = speed
	projectile.global_position = initial_position
	
	get_tree().get_root().add_child(projectile)
