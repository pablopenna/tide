class_name FactionUtils extends Node

enum Faction {
	PLAYER,
	ENEMY
}

static func are_enemies(faction1: Faction, faction2: Faction) -> bool:
	return faction1 != faction2
