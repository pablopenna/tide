extends Node2D

@export var shape: RectangleShape2D

#region properties
func _horizontal_apothem():
	return shape.size.x/2
	
func _vertical_apothem():
	return shape.size.y/2

func _right_position():
	return position.x + _horizontal_apothem()
	
func _left_position():
	return position.x - _horizontal_apothem()

func _top_position():
	return position.y - _vertical_apothem()

func _bottom_position():
	return position.y + _vertical_apothem()
#endregion

#region checks
func _is_target_box_outside_of_self(target_box):
	return _get_target_box_outside_of_self_direction(target_box) != Vector2.ZERO

func _get_target_box_outside_of_self_direction(target_box):
	var outside_direction: Vector2 = Vector2.ZERO
	
	if _is_right_of_target_box_outside_of_self(target_box):
		outside_direction.x = Vector2.RIGHT.x
	if _is_left_of_target_box_outside_of_self(target_box):
		outside_direction.x = Vector2.LEFT.x
	if _is_top_of_target_box_outside_of_self(target_box):
		outside_direction.y = Vector2.UP.y
	if _is_bottom_of_target_box_outside_of_self(target_box):
		outside_direction.y = Vector2.DOWN.y
	
	return outside_direction

func _is_right_of_target_box_outside_of_self(target_box):
	return target_box._right_position() > self._right_position()
	
func _is_left_of_target_box_outside_of_self(target_box):
	return target_box._left_position() < self._left_position()
	
func _is_top_of_target_box_outside_of_self(target_box):
	return target_box._top_position() < self._top_position()

func _is_bottom_of_target_box_outside_of_self(target_box):
	return target_box._bottom_position() > self._bottom_position()
#endregion

#region adjustments

func _adjust_position_to_target_box(target_box):
	var direction = _get_target_box_outside_of_self_direction(target_box)
	var adjusted = _get_adjusted_position(target_box, direction)
	position = adjusted

func _get_adjusted_position(target_box, adjustment_direction: Vector2):
	var adjusted_position = Vector2(position.x, position.y)
	
	if adjustment_direction.x == Vector2.RIGHT.x:
		adjusted_position.x = self._get_right_adjustment_position(target_box)
	if adjustment_direction.x == Vector2.LEFT.x:
		adjusted_position.x = self._get_left_adjustment_position(target_box)
	if adjustment_direction.y == Vector2.UP.y:
		adjusted_position.y = self._get_top_adjustment_position(target_box)
	if adjustment_direction.y == Vector2.DOWN.y:
		adjusted_position.y = self._get_bottom_adjustment_position(target_box)
	
	return adjusted_position

# Box B is static, we are not moving it. We want to move Box A so its right_side
# is at the same X position as Box B's
# ===
# A pos + A apothem = B pos + B apothem
# A pos = B pos + B apothem - A apothem
#
# If the result is negative, Box B is not to the right of Box A. So Box A
# should not be moved.
func _get_right_adjustment_position(target_box):
	return target_box._right_position() - self._horizontal_apothem()

func _get_left_adjustment_position(target_box):
	return target_box._left_position() + self._horizontal_apothem()
	
func _get_top_adjustment_position(target_box):
	return target_box._top_position() + self._vertical_apothem()
	
func _get_bottom_adjustment_position(target_box):
	return target_box._bottom_position() - self._vertical_apothem()
#endregion
