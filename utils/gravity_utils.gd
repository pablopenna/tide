class_name GravityUtils

static func get_gravity(): 
	return ProjectSettings.get_setting("physics/2d/default_gravity")


# Uniformly Accelerated Rectilinear Motion -> v = v0 + a*t
static func get_velocity_applying_acceleration(initial_velocity: float, acceleration: float, time: float):
	return initial_velocity + acceleration * time


static func get_velocity_applying_gravity(initial_velocity: float, time: float) -> float:
	return get_velocity_applying_acceleration(initial_velocity,get_gravity(),time)
