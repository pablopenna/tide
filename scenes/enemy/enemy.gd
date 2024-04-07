extends Entity

func _process(_delta):
	if Input.is_action_just_pressed("add_enemy_troop"):
		($TroopManager as TroopManager).create_troop()
