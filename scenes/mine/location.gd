class_name Location extends Area2D

@export var faction: FactionUtils.Faction
@export var troop_manager: TroopManager

func _ready():
	troop_manager.faction = faction
