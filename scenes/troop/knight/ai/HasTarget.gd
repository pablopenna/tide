extends ConditionLeaf

func tick(actor: Node, blackboard: Blackboard) -> int:
	var troop = actor as Troop
	if(TargetUtils.has_target(troop)):
		return SUCCESS
	else:
		return FAILURE
