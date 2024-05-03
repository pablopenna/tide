extends Troop

func attack_target(target: Node2D):
	# HACK: prevent changing the state on each frame when detecting enemy
	if state_machine.current_state.state_name != "attack":
		state_machine.change_to_state("attack", {"target": target})
	
func follow_owner():
	state_machine.change_to_state("follow", {"target": troop_owner})
