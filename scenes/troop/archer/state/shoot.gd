extends State

@export var projectile_shooter: ProjectileShooter

const MAX_DISTANCE_TO_TARGET = 200
const SHOOT_COOLDOWN = 1000
const PROJECTILE_SPEED = 500
const PROJECTILE_DAMAGE = 3

@onready var ticks_on_last_shoot = 0
var target

func _ready():
	state_name = "shoot"
	
func enter(context: Dictionary):
	target = context.get("target")
	managed_entity.velocity = Vector2.ZERO
	
func process(_delta):
	if(target == null or not _is_target_in_range()):
		change_to_state.emit("follow", {})
		return
	_shoot()
	

func _is_target_in_range() -> bool:
	return managed_entity.global_position.distance_to(target.global_position) < MAX_DISTANCE_TO_TARGET

func _shoot():
	if not _is_shoot_in_cooldown():
		projectile_shooter.shoot(
			managed_entity.global_position,
			managed_entity.global_position.direction_to(target.global_position), 
			PROJECTILE_SPEED,
			PROJECTILE_DAMAGE
		)
		ticks_on_last_shoot = Time.get_ticks_msec()
	
func _is_shoot_in_cooldown():
	return Time.get_ticks_msec() < ticks_on_last_shoot + SHOOT_COOLDOWN
