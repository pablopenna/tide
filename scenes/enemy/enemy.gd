extends Entity

func _process(_delta):
	if Input.is_action_just_pressed("enemy_troop_add_knight"):
		($TroopManager as TroopManager).create_knight()
	if Input.is_action_just_pressed("enemy_troop_add_archer"):
		($TroopManager as TroopManager).create_archer()
