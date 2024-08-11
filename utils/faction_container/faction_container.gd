class_name FactionContainer extends Node

signal faction_changed(faction: FactionUtils.Faction)
@export var faction: FactionUtils.Faction:
	set(value):
		faction = value
		faction_changed.emit(value)

