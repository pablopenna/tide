extends ActionLeaf

@export var projectile_shooter: ProjectileShooter

var troop: Troop
var shoot_cooldown
var projectile_speed
var projectile_damage
var ticks_on_last_shoot

func _ready() -> void:
	ticks_on_last_shoot = 0

func before_run(actor: Node, blackboard: Blackboard) -> void:
	troop = actor as Troop
	troop.velocity = Vector2.ZERO
	
	shoot_cooldown = troop.stats.shooting_cooldown_ms
	projectile_speed = troop.stats.projectile_speed
	projectile_damage = troop.stats.damage
	
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
			projectile_speed,
			projectile_damage
		)
		ticks_on_last_shoot = Time.get_ticks_msec()
	
func _is_shoot_in_cooldown():
	return Time.get_ticks_msec() < ticks_on_last_shoot + shoot_cooldown
