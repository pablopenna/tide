extends "./box.gd"

var target: Node2D

func _process(_delta):
	if target:
		position = target.position
