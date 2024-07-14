extends State

@export var projectile_shooter: ProjectileShooter
@export var get_in_range_state: State

const MAX_DISTANCE_TO_TARGET = 100
const SHOOT_COOLDOWN = 1000
const PROJECTILE_SPEED = 500
const PROJECTILE_DAMAGE = 3

@onready var ticks_on_last_shoot = 0
var target

@export var follow_leader_state: State

func _ready():
	state_name = "shoot"
	
func enter(context: Dictionary):
	target = context.get("target")
	managed_entity.velocity = Vector2.ZERO
	(managed_entity as Troop).ordered_to_follow_leader.connect(_on_ordered_to_follow_leader)

func exit(_new_state:State):
	(managed_entity as Troop).ordered_to_follow_leader.disconnect(_on_ordered_to_follow_leader)
	
func process(_delta):
	if(target == null):
		(managed_entity as Troop).follow_owner()
		return
	if(not _is_target_in_range()):
		change_to_state.emit(
			get_in_range_state.state_name, 
			{
				"target": target, 
				"range": MAX_DISTANCE_TO_TARGET
			})
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
	
func _on_ordered_to_follow_leader():
	change_to_state.emit(follow_leader_state.state_name, {})
