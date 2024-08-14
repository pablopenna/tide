extends State

func _ready():
	state_name = "default"

func _on_hurtbox_damaged(hit_data):
	print(hit_data)
