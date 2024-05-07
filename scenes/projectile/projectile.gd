class_name Projectile extends Hitbox

var direction
var speed

signal outOfScreen
signal destroyed # when destroying the projectile via queue_free(), VisibleOnScreenNotifier3D is triggered
	
func _process(delta):
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
