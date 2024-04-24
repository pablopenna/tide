class_name TroopManager extends Node

@export var troop_owner: Entity
@export var troop_scene: PackedScene
@export_flags_2d_physics var troops_hitbox_layer_scanned
@export_flags_2d_physics var troops_hurtbox_layer

@export var troop_detector: TroopDetector

var _troops: Array[Troop]
var _troop_spread_radius
const DEFAULT_TROOP_SPREAD_RADIUS = 50
const MIN_TROOP_SPPEED = 40
const MAX_TROOP_SPPEED = 80
var _rng

func _ready():
	_rng = RandomNumberGenerator.new()
	_troop_spread_radius = DEFAULT_TROOP_SPREAD_RADIUS
	if not troop_detector.is_node_ready():
		await troop_detector.ready
	troop_detector.targets_acquired.connect(make_troops_attack_targets)

func create_troop():
	var new_troop: Troop = troop_scene.instantiate() as Troop
	
	new_troop.initialize_with(
		troop_owner, 
		troops_hitbox_layer_scanned, 
		troops_hurtbox_layer, 
		_generate_troop_offset(), 
		_generate_troop_speed()
	)
	
	_troops.append(new_troop)
	new_troop.died.connect(_process_troop_death)
	add_child(new_troop)
	
func _process_troop_death(dead_troop: Troop):
	_troops.erase(dead_troop)

func _get_number_of_troops():
	return len(_troops)
	
func _generate_troop_offset():
	var random_x = _rng.randf_range(_troop_spread_radius * -1, _troop_spread_radius)
	var random_y = _rng.randf_range(_troop_spread_radius * -1, _troop_spread_radius)
	return Vector2(random_x, random_y)
	
func _generate_troop_speed():
	return _rng.randf_range(MIN_TROOP_SPPEED, MAX_TROOP_SPPEED)
	
func make_troops_attack_targets(targets: Array):
	var target = targets[0]
	for troop in _troops:
		troop.attack_target(target)
		
func make_troops_follow_leader():
	for troop in _troops:
		troop.follow_owner()
