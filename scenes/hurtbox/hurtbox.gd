class_name Hurtbox extends Area2D

signal damaged

@export var linked_entity: Entity

@export_flags_2d_physics var hurtbox_collision_layer
# the hurtbox will not scan, it will be passive. The hitbox is in charge of 
# detecting and triggering the hurtbox when they collision
# @export_flags_2d_physics var hitbox_collision_mask 

@export var show_debug_label = false

func _ready():
	collision_layer = hurtbox_collision_layer
	# collision_mask = hitbox_collision_mask
	if not show_debug_label:
		$RichTextLabel.queue_free()
	
func receiveDamage(hitboxData: HitboxData):
	emit_signal("damaged", hitboxData)
	if show_debug_label:
		$RichTextLabel.text = "Ouch!"
		await get_tree().create_timer(0.1).timeout
		$RichTextLabel.text = ""
		
static func get_hurtbox_from_collider(collider) -> Hurtbox:
	var hurtbox = collider as Hurtbox
	if hurtbox != null:
		return hurtbox
	return null
