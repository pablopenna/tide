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
const uuid_util = preload('res://addons/uuid/uuid.gd')
var _unique_group_id

func _ready():
	_rng = RandomNumberGenerator.new()
	_troop_spread_radius = DEFAULT_TROOP_SPREAD_RADIUS
	_unique_group_id = uuid_util.v4()

func create_troop():
	var new_troop: Troop = troop_scene.instantiate()
	
	new_troop.owner_entity = troop_owner
	new_troop.target_position_offset = _generate_troop_offset()
	new_troop.speed = _rng.randf_range(MIN_TROOP_SPPEED, MAX_TROOP_SPPEED)
	new_troop.position = troop_owner.position + new_troop.target_position_offset
	
	_troops.append(new_troop)
	add_child(new_troop)
	
func _get_number_of_troops():
	return len(_troops)
	
func _generate_troop_offset():
	var random_x = _rng.randf_range(_troop_spread_radius * -1, _troop_spread_radius)
	var random_y = _rng.randf_range(_troop_spread_radius * -1, _troop_spread_radius)
	return Vector2(random_x, random_y)
	
func make_troops_attack_targets(targets: Array):
	var target = targets[0]
	for troop in _troops:
		troop.attack_target(target)
		
func make_troops_follow_leader():
	for troop in _troops:
		troop.follow_owner()
