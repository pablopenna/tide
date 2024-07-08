extends State

const TARGET_POSITION_ACCEPTED_DISTANCE: float = 1
var target: Node2D
@export var hitbox: Hitbox

func _ready():
	state_name = "follow"
	
func enter(context):
	if context.get('target'):
		target = context.get('target')
	# HACK: Archers do not have hitboxes in their tree, their projectiles do
	if hitbox:
		hitbox.disable()
	
func process(_delta):
	if _should_move_to_target_position():
		managed_entity.velocity = _get_target_direction() * managed_entity.speed
	else:
		managed_entity.velocity = Vector2.ZERO

func _get_target() -> Node2D:
	if target:
		return target
	return managed_entity.troop_owner

func _get_target_position() -> Vector2:
	return _get_target().position + managed_entity.target_position_offset

func _get_target_direction() -> Vector2:
	return managed_entity.position.direction_to(_get_target_position())

func _get_distance_to_target_position() -> float:
	var target_position = _get_target_position()
	return managed_entity.position.distance_to(target_position)

func _should_move_to_target_position() -> bool:
	return _get_distance_to_target_position() >= TARGET_POSITION_ACCEPTED_DISTANCE

func _on_troop_ordered_to_attack_target(target):
	change_to_state.emit("attack", {'target': target})
