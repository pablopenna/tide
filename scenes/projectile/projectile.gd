class_name Projectile extends Hitbox

var direction
var speed

signal outOfScreen

func _process(delta):
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	self._destroy()

func _on_hit():
	self._destroy()

func _destroy():
	queue_free()
