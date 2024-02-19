extends "./box.gd"

var target: Node2D

func _process(delta):
	if target:
		position = target.position
