extends AnimationPlayer

func _on_change_state(new_state, old_state):
	match new_state:
		"idle":
			play("idle")
		"move":
			play("run")
		"idle_attack":
			play("attack")
		_:
			play("default")
