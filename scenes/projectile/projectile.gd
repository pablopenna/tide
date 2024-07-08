class_name Projectile extends Hitbox

var direction
var speed
var damage

signal outOfScreen

func _ready():
	super._ready()
	hitbox_data.damage = damage

func _process(delta):
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	self._destroy()

func _on_hit():
	self._destroy()

func _destroy():
	queue_free()
