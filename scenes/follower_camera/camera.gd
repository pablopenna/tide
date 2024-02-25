extends Camera2D

@export var big_box: Node2D

func _process(_delta):
	position = big_box.position
