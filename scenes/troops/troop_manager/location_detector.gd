class_name LocationDetector extends Area2D

signal mine_detected(mine: Mine)
@export var active_scan_timer: Timer

func _ready() -> void:
	area_entered.connect(_on_location_interact)
	active_scan_timer.timeout.connect(_active_scan)

func _active_scan() -> void:
	for area: Area2D in get_overlapping_areas():
		_on_location_interact(area)

func _on_location_interact(area: Area2D) -> void:
	_process_mine(area)

func _process_mine(area: Area2D) -> void:
	var mine := area as Mine
	if mine == null:
		return
	mine_detected.emit(mine)
