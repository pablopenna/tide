class_name TroopDetector extends ShapeCast2D

@export var faction: FactionUtils.Faction:
	set(value):
		faction = value
		collision_mask = FactionUtils.get_hitbox_collision_mask_for_faction(faction)
@export var owner_entity: Node2D
var default_direction: Vector2 = Vector2.RIGHT
var current_direction: Vector2

signal targets_acquired(target_hurtbox: Array)

func _ready() -> void:
	current_direction = default_direction
	collision_mask = FactionUtils.get_hitbox_collision_mask_for_faction(faction)

func _process(delta: float) -> void:
	_rotate_to_match_entity_direction()
	_process_collisions()
	
func _rotate_to_match_entity_direction() -> void:
	var entity_direction: Vector2
	if owner_entity as Entity != null:
		entity_direction = owner_entity.velocity.normalized()
	else:
		entity_direction = Vector2.RIGHT
	var rotation_diff: float = current_direction.angle_to(entity_direction)
	
	rotate(rotation_diff)
	
	current_direction = current_direction.rotated(rotation_diff)

func _process_collisions() -> void:
	var count: int = 0
	var targets_found: Array = []
	
	while get_collision_count() > count:
		var current_collision: Area2D = get_collider(count)
		var current_target = current_collision as Hurtbox
		if current_target != null:
			targets_found.append(current_target)
		count += 1
	
	if len(targets_found) > 0:
		_process_targets(targets_found)
	
func _process_targets(targets: Array) -> void:
	targets_acquired.emit(targets)
