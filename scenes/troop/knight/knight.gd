class_name Knight extends Troop

const ATTACK_STATE_NAME = "attack"

func attack_target(target: Node2D):
	# HACK: prevent changing the state on each frame when detecting enemy
	if state_machine.current_state.state_name != ATTACK_STATE_NAME:
		state_machine.change_to_state(ATTACK_STATE_NAME, {"target": target})
	
func follow_owner():
	state_machine.change_to_state("follow", {"target": troop_owner})
