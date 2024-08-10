class_name Location extends Area2D

@export var faction: FactionUtils.Faction
@export var factory: TroopFactory
@export var commander: TroopCommander
@export var troops: TroopTracker
@export var troop_detectors: Array[TroopDetector]
@export var initial_knights: int
@export var initial_archers: int

func _ready():
	factory.faction = faction
	for detector: TroopDetector in troop_detectors:
		detector.faction = faction
	_create_initial_troops()

func _create_initial_troops() -> void:
	for i:int in range(initial_knights):
		factory.create_knight()
	for i:int in range(initial_archers):
		factory.create_archer()
