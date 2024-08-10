extends Area2D

func _ready() -> void:
	area_entered.connect(_on_location_interact)
	
func _on_location_interact(area: Area2D) -> void:
	_process_mine(area)

func _process_mine(area: Area2D) -> void:
	var mine := area as Mine
	if mine == null:
		return
	print("I'm in a mine")
