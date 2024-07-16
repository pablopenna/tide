class_name TroopDetector extends ShapeCast2D

@export var owner_entity: Entity
var default_direction: Vector2 = Vector2.RIGHT
var current_direction: Vector2

signal targets_acquired(target_hurtbox: Array)

func _ready() -> void:
	current_direction = default_direction

func _process(delta: float) -> void:
	_rotate_to_match_entity_direction()
	_process_collisions()
	
func _rotate_to_match_entity_direction() -> void:
	var entity_direction: Vector2 = owner_entity.velocity.normalized()
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
