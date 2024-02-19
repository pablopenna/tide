extends "./box.gd"

const speed = 100
@export var target_box: Node2D

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		position += Vector2.RIGHT * speed * delta
	if Input.is_action_pressed("ui_left"):
		position += Vector2.LEFT * speed * delta
	if Input.is_action_pressed("ui_up"):
		position += Vector2.UP * speed * delta
	if Input.is_action_pressed("ui_down"):
		position += Vector2.DOWN * speed * delta
	
	_check_target_box()
	
func _check_target_box():
	if self._is_target_box_outside_of_self(target_box):
		self._adjust_position_to_target_box(target_box)
	
