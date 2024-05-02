extends Node

const DEFAULT_TROOP_SPREAD_RADIUS = 50
const MIN_TROOP_SPEED = 40
const MAX_TROOP_SPEED = 80

var troop_owner: Entity
var troop_scene: PackedScene
var troops_layer_scanned_by_hitbox
var troops_hurtbox_layer
var troop_detector: TroopDetector
var troops: Array[Troop]

var _troop_spread_radius
var _rng

func _ready():
	_rng = RandomNumberGenerator.new()
	_troop_spread_radius = DEFAULT_TROOP_SPREAD_RADIUS

func create_troop():
	var new_troop: Troop = troop_scene.instantiate() as Troop
	
	new_troop.initialize_with(
		troop_owner, 
		troops_layer_scanned_by_hitbox, 
		troops_hurtbox_layer, 
		_generate_troop_position_offset(), 
		_generate_troop_speed()
	)
	
	troops.append(new_troop)
	new_troop.died.connect(_process_troop_death)
	add_child(new_troop)
	
func _process_troop_death(dead_troop: Troop):
	troops.erase(dead_troop)

func _get_number_of_troops():
	return len(troops)
	
func _generate_troop_position_offset():
	var random_x = _rng.randf_range(_troop_spread_radius * -1, _troop_spread_radius)
	var random_y = _rng.randf_range(_troop_spread_radius * -1, _troop_spread_radius)
	return Vector2(random_x, random_y)
	
func _generate_troop_speed():
	return _rng.randf_range(MIN_TROOP_SPEED, MAX_TROOP_SPEED)

func _on_troop_manager_troops_provided(troops):
	self.troops = troops

func _on_troop_manager_troops_hurtbox_layer_provided(hurtbox_layer):
	self.troops_hurtbox_layer = hurtbox_layer

func _on_troop_manager_troops_hitbox_layer_scanned_provided(hitbox_layer):
	self.troops_layer_scanned_by_hitbox = hitbox_layer

func _on_troop_manager_troop_scene_provided(troop_scene):
	self.troop_scene = troop_scene

func _on_troop_manager_troop_owner_provided(troop_owner):
	self.troop_owner = troop_owner
