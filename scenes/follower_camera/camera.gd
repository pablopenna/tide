extends Camera2D

@export var big_box: Node2D

func _process(delta):
	position = big_box.position
