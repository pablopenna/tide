class_name Cooldown extends Node

@export var cooldown: int
var _last_time_triggered: int = 0

func _init(cooldown: int):
	self.cooldown = cooldown

func check() -> bool:
	return Time.get_ticks_msec() > _last_time_triggered + cooldown
	
func trigger() -> bool:
	if not check():
		return false
	_last_time_triggered = Time.get_ticks_msec()
	return true
