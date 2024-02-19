extends RichTextLabel

@export var node_to_follow: Node2D
@export var text_offset: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _process(delta):
	if node_to_follow != null:
		position = node_to_follow.position + text_offset

func _on_state_change(new_state_name: String, old_state: String):
	self.text = new_state_name
