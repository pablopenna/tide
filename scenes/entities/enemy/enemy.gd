extends Entity

@export var factory: TroopFactory

func _process(_delta):
	if Input.is_action_just_pressed("enemy_troop_add_knight"):
		factory.create_knight()
	if Input.is_action_just_pressed("enemy_troop_add_archer"):
		factory.create_archer()
