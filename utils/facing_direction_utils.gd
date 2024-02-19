class_name FacingDirectionUtils

static func getFacingDirectionFromVelocityWithDefault(velocity: Vector2, defaultWhenVelocityIsZero: Vector2):
	if velocity.y != 0:
		return Vector2.UP if velocity.y < 0 else Vector2.DOWN
	if velocity.x != 0:
		return Vector2.LEFT if velocity.x < 0 else Vector2.RIGHT
	else:
		return defaultWhenVelocityIsZero

static func getFacingDirectionFromVelocity(velocity: Vector2):
	return getFacingDirectionFromVelocityWithDefault(velocity, Vector2.DOWN)
