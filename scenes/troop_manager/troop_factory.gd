class_name TroopFactory extends Node

@export var troop_owner: Node2D
@export var faction: FactionContainer
@export var knight_scene: PackedScene
@export var archer_scene: PackedScene

@export var troop_spread_radius = 50
@export var min_troop_speed = 40
@export var max_troop_speed = 80

signal troop_created(troop: Troop)

func create_knight():
	_create_troop(knight_scene)

func create_archer():
	_create_troop(archer_scene)

func _create_troop(troop_scene: PackedScene):
	var new_troop: Troop = troop_scene.instantiate() as Troop
	
	new_troop.initialize_with(
		troop_owner, 
		_generate_troop_position_offset(), 
		_generate_troop_speed(),
		faction.faction
	)
	
	troop_created.emit(new_troop)
	# Even if ancestor node has Y sorting enabled, does not work if parent of troop is a Node
	# This should instantiate the troop at the same level of the troop owner in the tree
	troop_owner.get_parent().add_child(new_troop)
	
func _generate_troop_position_offset():
	var random_x = randf_range(troop_spread_radius * -1, troop_spread_radius)
	var random_y = randf_range(troop_spread_radius * -1, troop_spread_radius)
	return Vector2(random_x, random_y).normalized() * troop_spread_radius
	
func _generate_troop_speed():
	return randf_range(min_troop_speed, max_troop_speed)
