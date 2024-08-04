# The hitbox scans for hurtboxes by setting its mask to match the layer the hurtboxes are in
# We can set the layer of the hitbox so it can be detected by other collisions
class_name Hitbox extends Area2D

@export var hitbox_data: HitboxData
var is_enabled: bool
signal hit

func _ready() -> void: 
	area_entered.connect(_on_area_entered)
	# hitbox_data = find_children("*", "HitboxData")[0]
	
func _on_area_entered(area: Area2D) -> void:
	var hurtbox: Hurtbox = area as Hurtbox # Casting returns null if cannot convert to type
	if hurtbox != null:
		_on_hurtbox_entered(hurtbox)

func enable() -> void:
	monitoring = true
	monitorable = true
	is_enabled = true

func disable() -> void:
	monitoring = false
	monitorable = false
	is_enabled = false

func _on_hurtbox_entered(hurtbox: Hurtbox) -> void:
	hit.emit()
	hurtbox.receiveDamage(hitbox_data)
