class_name Archer extends Troop

const ATTACK_STATE_NAME = "shoot"

@export var projectile_shooter: ProjectileShooter

func attack_target(target: Node2D):
	# HACK: prevent changing the state on each frame when detecting enemy
	if state_machine.current_state.state_name != ATTACK_STATE_NAME:
		state_machine.change_to_state(ATTACK_STATE_NAME, {"target": target})
	
func follow_owner():
	state_machine.change_to_state("follow", {"target": troop_owner})

func initialize_with(
	owner: Node2D, 
	hitbox_layer: int, 
	hurtbox_layer: int, 
	position_offset: Vector2, 
	speed: float
):
	super.initialize_with(owner, hitbox_layer, hurtbox_layer, position_offset, speed)
	projectile_shooter.projectile_scanned_layer = hitbox_layer
	
