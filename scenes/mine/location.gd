class_name Location extends Area2D

@export var factory: TroopFactory
@export var commander: TroopCommander
@export var troops: TroopTracker
@export var troop_detectors: Array[TroopDetector]
@export var faction: FactionContainer

@export var initial_knights: int
@export var initial_archers: int

@onready var conquer_cooldown: Cooldown = Cooldown.new(1000)


func _ready():
	_create_initial_troops()

func _create_initial_troops() -> void:
	for i:int in range(initial_knights):
		factory.create_knight()
	for i:int in range(initial_archers):
		factory.create_archer()

func conquer(faction: FactionUtils.Faction) -> bool:
	if self.faction.faction == faction:
		return false
	if troops.get_number_of_troops() > 0:
		return false
	if not conquer_cooldown.check():
		return false
	self.faction.faction = faction
	conquer_cooldown.trigger()
	factory.create_knight.call_deferred()
	return true




