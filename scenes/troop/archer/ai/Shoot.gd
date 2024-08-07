extends ActionLeaf

@export var projectile_shooter: ProjectileShooter

const SHOOT_COOLDOWN = 1000
const PROJECTILE_SPEED = 500
const PROJECTILE_DAMAGE = 3

var troop: Troop
@onready var ticks_on_last_shoot = 0

func before_run(actor: Node, blackboard: Blackboard) -> void:
	troop = actor as Troop
	troop.velocity = Vector2.ZERO
	
func tick(actor: Node, blackboard: Blackboard) -> int:
	if not TargetUtils.has_target(troop):
		return SUCCESS
	if not TargetUtils.is_target_in_range(troop):
		return FAILURE
	_shoot()
	return RUNNING
	
func _shoot():
	if not _is_shoot_in_cooldown():
		projectile_shooter.shoot(
			troop.global_position,
			troop.global_position.direction_to(troop.target.global_position), 
			PROJECTILE_SPEED,
			PROJECTILE_DAMAGE
		)
		ticks_on_last_shoot = Time.get_ticks_msec()
	
func _is_shoot_in_cooldown():
	return Time.get_ticks_msec() < ticks_on_last_shoot + SHOOT_COOLDOWN
