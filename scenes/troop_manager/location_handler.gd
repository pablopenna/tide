extends Node

@export var location_detector: LocationDetector
@export var troops: TroopTracker
@export var faction: FactionContainer

func _ready() -> void:
	location_detector.mine_detected.connect(_handle_mine)

func _handle_mine(mine: Mine) -> void:
	mine.conquer(faction.faction)
