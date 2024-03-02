class_name TroopManager extends Node

@export var troop_owner: Entity
@export_flags_2d_physics var generated_troops_layer
@export var troop_scene: PackedScene

var _troops: Array[Troop]
var _troop_spread_radius
const DEFAULT_TROOP_SPREAD_RADIUS = 50
const MIN_TROOP_SPPEED = 40
const MAX_TROOP_SPPEED = 80
var _rng 

func _ready():
	_rng = RandomNumberGenerator.new()
	_troop_spread_radius = DEFAULT_TROOP_SPREAD_RADIUS

func create_troop():
	var new_troop: Troop = troop_scene.instantiate()
	
	new_troop.owner_entity = troop_owner
	new_troop.target_position_offset = _generate_troop_offset()
	new_troop.speed = _rng.randf_range(MIN_TROOP_SPPEED, MAX_TROOP_SPPEED)
	
	add_child(new_troop)
	
	# Need to call it after add_child so that the troop_entity field is initialized (because it is init'd within _ready)
	new_troop.troop_entity.position = troop_owner.position + new_troop.target_position_offset
	
func _get_number_of_troops():
	return len(_troops)
	
func _generate_troop_offset():
	var random_x = _rng.randf_range(_troop_spread_radius * -1, _troop_spread_radius)
	var random_y = _rng.randf_range(_troop_spread_radius * -1, _troop_spread_radius)
	return Vector2(random_x, random_y)
