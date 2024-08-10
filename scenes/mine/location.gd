class_name Location extends Area2D

@export var faction: FactionUtils.Faction
@export var factory: TroopFactory
@export var commander: TroopCommander

func _ready():
	factory.faction = faction
