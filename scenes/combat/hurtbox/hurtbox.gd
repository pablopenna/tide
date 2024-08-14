# The Hurtbox will not scan, it will be passive. The hitbox is in charge of 
# detecting and triggering the hurtbox when they collision	

class_name Hurtbox extends Area2D

signal damaged(damage: int)

@export var show_debug_label: bool = false

func _ready() -> void:
	if not show_debug_label:
		$RichTextLabel.queue_free()
	
func receiveDamage(damage: int) -> void:
	emit_signal("damaged", damage)
	if show_debug_label:
		$RichTextLabel.text = "Ouch!"
		await get_tree().create_timer(0.1).timeout
		$RichTextLabel.text = ""
		
static func get_hurtbox_from_collider(collider: Area2D) -> Hurtbox:
	var hurtbox: Hurtbox = collider as Hurtbox
	if hurtbox != null:
		return hurtbox
	return null
