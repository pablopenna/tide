class_name FactionUtils extends Node

enum Faction {
	PLAYER,
	ENEMY
}

static func are_enemies(faction1: Faction, faction2: Faction) -> bool:
	return faction1 != faction2
	
static func get_hitbox_collision_layer_for_faction(faction: Faction) -> int:
	match faction:
		Faction.PLAYER:
			return PhysicsLayersNamesUtils.get_collision_layer_from_name(PhysicsLayersNamesUtils.PLAYER_HITBOX)
		Faction.ENEMY:
			return PhysicsLayersNamesUtils.get_collision_layer_from_name(PhysicsLayersNamesUtils.ENEMY_HITBOX)
		_:
			push_error("collision layer not found")
			return 0
	
	
static func get_hitbox_collision_mask_for_faction(faction: Faction) -> int:
	match faction:
		Faction.PLAYER:
			return PhysicsLayersNamesUtils.get_collision_layer_from_name(PhysicsLayersNamesUtils.ENEMY_HURTBOX)
		Faction.ENEMY:
			return PhysicsLayersNamesUtils.get_collision_layer_from_name(PhysicsLayersNamesUtils.PLAYER_HURTBOX)
		_:
			push_error("collision mask not found")
			return 0
			
static func get_hurtbox_collision_layer_for_faction(faction: Faction) -> int:
	match faction:
		Faction.PLAYER:
			return PhysicsLayersNamesUtils.get_collision_layer_from_name(PhysicsLayersNamesUtils.PLAYER_HURTBOX)
		Faction.ENEMY:
			return PhysicsLayersNamesUtils.get_collision_layer_from_name(PhysicsLayersNamesUtils.ENEMY_HURTBOX)
		_:
			push_error("collision layer not found")
			return 0

static func get_hurtbox_collision_mask_for_faction(faction: Faction) -> int:
	match faction:
		Faction.PLAYER:
			return 0
		Faction.ENEMY:
			return 0
		_:
			push_error("collision mask not found")
			return 0
